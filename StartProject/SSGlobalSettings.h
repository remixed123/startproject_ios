//
//  SSGlobalSettings.h
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSConnection.h"

@interface SSGlobalSettings : NSObject
{
    NSString    *ipAddress;
    long         portNumber;
}

@property (nonatomic, retain) NSString* ipAddress;
@property (nonatomic) long portNumber;

+ (id)sharedManager;
- (id)init;

@end
