//
//  SSUtilities.m
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import "SSUtilities.h"
#import <math.h>
#import "SSGlobalSettings.h"

@implementation SSUtilities

- (NSString*)intToHex :(int)intValue
{
    NSString *hexString;
    
    if (intValue < 16)
    {
        hexString = [NSString stringWithFormat:@"0%X",intValue];
    }
    else
    {
        hexString = [NSString stringWithFormat:@"%X", intValue];
    }
    
    return hexString;
}

- (NSString*)intToHex2Byte:(int)intValue
{
    NSString *hexString;
    
    if (intValue < 16)
    {
        hexString = [NSString stringWithFormat:@"000%X",intValue];
    }
    else if (intValue < 256)
    {
        hexString = [NSString stringWithFormat:@"00%X",intValue];
    }
    else if (intValue < 4096)
    {
        hexString = [NSString stringWithFormat:@"0%X",intValue];
    }
    else
    {
        hexString = [NSString stringWithFormat:@"%X", intValue];
    }
    
    return hexString;
}

- (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    
    NSLog(@"stringToHex: %@", hexString);
    
    return hexString;
}

@end

