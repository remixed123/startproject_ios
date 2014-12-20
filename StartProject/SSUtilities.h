//
//  SSUtilities.h
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSUtilities : NSObject
{
    
}

- (NSString*)intToHex:(int)intValue;
- (NSString*)intToHex2Byte:(int)intValue;
- (NSString *)stringToHex:(NSString *)str;

@end
