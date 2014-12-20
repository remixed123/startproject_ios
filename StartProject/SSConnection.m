//
//  SSConnection.m
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import "SSConnection.h"
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
#import "SSGlobalSettings.h"
#import "SSUtilities.h"
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>


@interface SSConnection ()
{
    long tag;
}

@end

@implementation SSConnection

GCDAsyncUdpSocket *udpSocket;

- (void)initNetworkCommunication
{
    
    if (udpSocket == nil)
    {
        udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [udpSocket enableBroadcast:YES error:nil];
    }
    
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
	// You could add checks here
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
	// You could add checks here
}


//////////////////////////////////////////////
// This send a UDP packet
//////////////////////////////////////////////
- (void)sendBytePacket:(NSData*)singlePacket
{
    NSString *ipAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"ipAddress"];

    int portNumber = 4000;
    

    NSString *host = ipAddress;
    if ([host length] == 0)
    {
        NSLog(@"Address required");
        return;
    }
    
    int port = portNumber;
    if (port <= 0 || port > 65535)
    {
        NSLog(@"Valid port required");
        return;
    }
    
    if ([singlePacket length] == 0)
    {
        NSLog(@"Message required");
        return;
    }
    
    if (udpSocket == nil)
    {
        [self initNetworkCommunication];
    }
    
    [udpSocket sendData:singlePacket toHost:host port:port withTimeout:-1 tag:tag];
    
    NSLog(@"sendBytePacket: singlePacket: %@",singlePacket);
    
    tag++;

}


@end
