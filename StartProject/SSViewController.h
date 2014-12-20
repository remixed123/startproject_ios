//
//  SSViewController.h
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "SSUtilities.h"
#import "SSConnection.h"
#import "SmartConfigGlobalConfig.h"
#import "SmartConfigDiscoverMDNS.h"

@interface SSViewController : UIViewController <AVAudioPlayerDelegate>
{
    SSConnection*   conn;
    SSUtilities*    utils;
}

@property (strong, nonatomic) UIButton *redOnButton;
@property (strong, nonatomic) UIButton *redOffButton;
@property (strong, nonatomic) UIButton *orangeOnButton;
@property (strong, nonatomic) UIButton *orangeOffButton;

@property (strong, nonatomic) UIButton *configButton;
@property (strong, nonatomic) UIButton *githubButton;

@property (nonatomic, retain) SmartConfigGlobalConfig *globalConfig;
@property (strong, nonatomic) SmartConfigDiscoverMDNS *mdnsService;

@property (nonatomic, retain) NSMutableDictionary *devices;
@property (nonatomic, retain) NSMutableDictionary *recentDevices;
@property (nonatomic, retain) NSTimer *refreshTimer;

-(IBAction)redOn:(id)sender;
-(IBAction)redOff:(id)sender;
-(IBAction)orangeOn:(id)sender;
-(IBAction)orangeOff:(id)sender;

- (IBAction)configPressed:(id)sender;
- (IBAction)githubPressed:(id)sender;

@end
