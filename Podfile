xcodeproj 'SignalR.Client.ObjC/SignalR.Client.ObjC'
workspace 'SignalR.Client.ObjC'

target :"SignalR.Client.iOS", :exclusive => true do
  platform :ios, '6.0'
  pod 'AFNetworking', '2.4.0'
  pod 'SocketRocket', '0.3.1-beta2'
end

target :"SignalR.Client.OSX", :exclusive => true do
  platform :osx, '10.8'
  pod 'AFNetworking', '2.4.0'
  pod 'SocketRocket', '0.3.1-beta2'
end

target :"SignalR.Client.Tests.OSX" do
    platform :osx, '10.8'
    pod 'OCMock', '~> 2.0.1'
    pod 'SocketRocket', '0.3.1-beta2'
    pod 'AFNetworking', '2.4.0'
end

