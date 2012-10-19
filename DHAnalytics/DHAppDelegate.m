//
//  DHAppDelegate.m
//  DHAnalytics
//
//  Created by Tim Shi on 10/18/12.
//  Copyright (c) 2012 Tim Shi. All rights reserved.
//

#import "DHAppDelegate.h"

#define TEST_FLIGHT_TEAM_TOKEN @"d8441f4ecdeedfda73e230bf1a2511e7_MTQ1MjkzMjAxMi0xMC0xOSAwMzowNzowOC45MzczODc"
#define PARSE_APP_ID @"G1rjWspxnoeF72Qxf6LddyhHqEzlaY51cMuq66TR"
#define PARSE_KEY @"yc4lJvF4VoRFDdD6g6qcAYBLGugq6TGWjWeSnDUp"
#define GAN_TRACKING_ID @"UA-35695361-1"
#define FB_APP_ID @"383720358362823"

static const NSInteger kGANDispatchPeriodSec = 10;

@implementation DHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:PARSE_APP_ID
                  clientKey:PARSE_KEY];
    [PFFacebookUtils initializeWithApplicationId:FB_APP_ID];
    [TestFlight takeOff:TEST_FLIGHT_TEAM_TOKEN];
    [[GANTracker sharedTracker] startTrackerWithAccountID:GAN_TRACKING_ID dispatchPeriod:kGANDispatchPeriodSec delegate:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
