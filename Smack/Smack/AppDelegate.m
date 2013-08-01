//
//  AppDelegate.m
//  Smack
//
//  Created by Zack Ulrich on 5/10/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self customizeAppearence];
    
    [Parse setApplicationId:@"p5deORQj2iTD6KOZouQhCLTMq8QJZ7bTLxgqR80s"
                  clientKey:@"oCRac0xNjuHW4tjzgdv1DwvGcG3ZNA9BiLynm3fq"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
   

    
    return YES;
}

-(void)customizeAppearence
{
    UIImage *gradImage = [[UIImage imageNamed:@"blue_gray_gradient_44"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [[UINavigationBar appearance] setBackgroundImage:gradImage forBarMetrics:UIBarMetricsDefault];
    
    //[[UISearchBar appearance] setBackgroundImage:gradImage forBarMetrics:UIBarMetricsDefault];
    
    //[[UIButton appearance] setBackgroundImage:gradImage forBarMetrics:UIBarMetricsDefault];
    
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:1.0/255.0 green:30.0/255.0 blue:65.0/255.0 alpha:1.0]];
    
    [[UIStepper appearance] setTintColor:[UIColor colorWithRed:1.0/255.0 green:30.0/255.0 blue:65.0/255.0 alpha:1.0]];
    //[[UIStepper appearance] setIncrementImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    //[[UIStepper appearance] setDecrementImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
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
