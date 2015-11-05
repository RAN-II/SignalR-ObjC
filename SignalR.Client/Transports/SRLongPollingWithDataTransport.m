//
//  SRLongPollingWithDataTransport.m
//  SignalR
//
//  Created by Alexander Rozhkov on 05.11.15.
//  Copyright © 2015 Polonium Arts. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
//  to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of
//  the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//  THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import "SRLongPollingWithDataTransport.h"
#import "SRHttpBasedTransport_Private.h"

@implementation SRLongPollingWithDataTransport

#pragma mark SRClientTransportInterface

- (NSString *)name {
    return @"longPollingWithData";
}

- (void)send:(id<SRConnectionInterface>)connection data:(NSData *)data connectionData:(NSString *)connectionData completionHandler:(void (^)(id response, NSError *error))block {
    id parameters = [self connectionParameters:connection connectionData:connectionData];
    
    //TODO: this is a little strange but SignalR Expects the parameters in the queryString and fails if in the body.
    //So we let AFNetworking Generate our URL with proper encoding and then create the POST url which will encode the data in the body.
    NSMutableURLRequest *url = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[connection.url stringByAppendingString:@"send"] parameters:parameters error:nil];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[[url URL] absoluteString] parameters:@{ @"data" : data } error:nil];
    [connection prepareRequest:request]; //TODO: prepareRequest
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    //operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    //operation.credential = self.credential;
    //operation.securityPolicy = self.securityPolicy;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [connection didReceiveData:responseObject];
        if(block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [connection didReceiveError:error];
        if (block) {
            block(nil, error);
        }
    }];
    [operation start];
}

@end
