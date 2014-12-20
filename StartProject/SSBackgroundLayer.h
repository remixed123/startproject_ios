//
//  SSBackGroundLayer.h
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SSBackgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;
+(CAGradientLayer*) darkGreyGradient;

@end