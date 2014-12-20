//
//  SSConnection.h
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSUtilities.h"

@class SSConnection;

@interface SSConnection : NSObject <UITabBarControllerDelegate>
{
    NSInputStream   *inputStream;
    NSOutputStream  *outputStream;
    
    SSUtilities     *utils;
}

- (void)initNetworkCommunication;
- (void)sendBytePacket:(NSData*)singlePacket;

@end
