//
//  SSViewController.m
//  StartProject
//
//  Created by Glenn Vassallo on 21/12/14.
//  Copyright (c) 2013 Swift Software. All rights reserved.
//

#import "SSViewController.h"
#import "SSConnection.h"
#import "SSUtilities.h"
#import <AVFoundation/AVFoundation.h>
#import "SSGlobalSettings.h"
#import "SSBackgroundLayer.h"
#import "SmartConfigGlobalConfig.h"

@interface NSString (NSStringHexToBytes)
-(NSData*) hexToBytes ;
@end

@interface SSViewController ()

@end


@implementation SSViewController

@synthesize redOffButton;
@synthesize redOnButton;
@synthesize orangeOffButton;
@synthesize orangeOnButton;
@synthesize configButton;
@synthesize githubButton;

static NSString  *deviceUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    conn = [[SSConnection alloc] init];
    
    // start MDNS discovery
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self selector:@selector(refreshTable)
                                   userInfo:nil repeats:YES];

    self.mdnsService = [SmartConfigDiscoverMDNS getInstance];
    [self.mdnsService startMDNSDiscovery:@""];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CAGradientLayer *bgLayer = [SSBackgroundLayer darkGreyGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
}

-(void)viewWillDisappear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshMDNS
{
    [self populateDevicesList];
    [self.mdnsService emptyMDNSList];
    [self.mdnsService startMDNSDiscovery:@"" ];
    
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(stopRefresh:) userInfo:nil repeats:NO];
}

- (void)populateDevicesList
{
    self.recentDevices = [[NSMutableDictionary alloc] init];
    self.devices = [[NSMutableDictionary alloc] init];
    
    SmartConfigGlobalConfig *globalConfig = [SmartConfigGlobalConfig getInstance];
    NSMutableDictionary *devices = [globalConfig getDevices];
    
    NSMutableDictionary *device;
    
    for(id key in devices) {
        device = [devices objectForKey:key];
        BOOL recent = [[device objectForKey:@"recent"] boolValue];
        if(recent == YES) {
            if(self.recentDevices == nil) {
                self.recentDevices = [[NSMutableDictionary alloc] initWithObjectsAndKeys:device,key,nil];
            } else {
                [self.recentDevices setObject:device forKey:key];
            }
        } else {
            if(self.devices == nil) {
                self.devices = [[NSMutableDictionary alloc] initWithObjectsAndKeys:device,key,nil];
            } else {
                [self.devices setObject:device forKey:key];
            }
        }
    }
    
    // Store the IP address. This really only works with one device on the network at the moment
    // For multiple devices, you need to code a lot more......
    deviceUrl = [device objectForKey:@"url"];
    
    // Store the IP adress in the global settings
    NSString *deviceIpAddress  = [deviceUrl stringByReplacingOccurrencesOfString:@":80" withString:@""];
    deviceIpAddress  = [deviceIpAddress stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:deviceIpAddress forKey:@"ipAddress"];

}

- (void) refreshTable
{
    [self populateDevicesList];
}


- (void)stopRefresh:(id)sender

{
    self.refreshTimer = nil;
}


-(IBAction)redOff:(id)sender
{
    NSString *dataPacket = @"FF00";
    NSData *udpPacket = [dataPacket hexToBytes];
    [conn sendBytePacket:udpPacket];
}

-(IBAction)redOn:(id)sender
{
    NSString *dataPacket = @"FF11";
    NSData *udpPacket = [dataPacket hexToBytes];
    [conn sendBytePacket:udpPacket];
}

-(IBAction)orangeOff:(id)sender
{
    NSString *dataPacket = @"EE00";
    NSData *udpPacket = [dataPacket hexToBytes];
    [conn sendBytePacket:udpPacket];
}

-(IBAction)orangeOn:(id)sender
{
    NSString *dataPacket = @"EE11";
    NSData *udpPacket = [dataPacket hexToBytes];
    [conn sendBytePacket:udpPacket];
}

// Opens the CC3200 internal website's configration page
- (IBAction)configPressed:(id)sender
{
    NSString *deviceWebAddress  = [deviceUrl stringByReplacingOccurrencesOfString:@":4000" withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:deviceWebAddress]];
}

// Opens the Github repository in a browser
- (IBAction)githubPressed:(id)sender
{
    NSString *fullURL = @"https://github.com/remixed123";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fullURL]];
}

@end
                         
                         
@implementation NSString (NSStringHexToBytes)

- (NSData *)hexToBytes
{
    const char *chars = [self UTF8String];
    int i = 0;
    long len = self.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}
                         
@end