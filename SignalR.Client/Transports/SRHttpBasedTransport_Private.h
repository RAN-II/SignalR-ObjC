//
//  SRHttpBasedTransport_Private.h
//  SignalR.Client.ObjC
//
//  Created by Alexander Rozhkov on 05.11.15.
//  Copyright © 2015 DyKnow LLC. All rights reserved.
//

#ifndef SRHttpBasedTransport_Private_h
#define SRHttpBasedTransport_Private_h

#import <AFNetworking/AFNetworking.h>
#import "SRConnectionInterface.h"
#import "SRLog.h"
#import "SRNegotiationResponse.h"

#import "NSObject+SRJSON.h"


@interface SRHttpBasedTransport ()

- (NSDictionary *)connectionParameters:(id <SRConnectionInterface>)connection connectionData:(NSString *)connectionData;

- (NSDictionary *)addClientProtocol:(NSDictionary *)parameters connection:(id <SRConnectionInterface>)connection;

- (NSDictionary *)addTransport:(NSDictionary *)parameters transport:(NSString *)transport;

- (NSDictionary *)addConnectionData:(NSDictionary *)parameters connectionData:(NSString *)connectionData;

- (NSDictionary *)addConnectionToken:(NSDictionary *)parameters connection:(id <SRConnectionInterface>)connection;

- (NSDictionary *)addQueryString:(NSDictionary *)parameters connection:(id <SRConnectionInterface>)connection;

@end

#endif /* SRHttpBasedTransport_Private_h */
