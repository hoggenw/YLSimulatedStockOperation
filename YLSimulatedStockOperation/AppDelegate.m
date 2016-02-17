//
//  AppDelegate.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/11/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "AppDelegate.h"
#import "YLLetfViewController.h"
#import "YLMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:[[YLMainViewController alloc]init]];
    YLLetfViewController *leftVc=[[YLLetfViewController alloc]init];
    RESideMenu *sideMenuViewController=[[RESideMenu alloc]initWithContentViewController:navi leftMenuViewController:leftVc rightMenuViewController:nil];
    sideMenuViewController.parallaxEnabled = NO;
    sideMenuViewController.scaleContentView = YES;
    sideMenuViewController.contentViewScaleValue = 0.98;
    sideMenuViewController.scaleMenuView = NO;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewShadowRadius = 4.5;
    NSUserDefaults *useDef=[NSUserDefaults standardUserDefaults];
    BOOL isFirstIn=[useDef boolForKey:@"isFirstIn"];
    if (!isFirstIn) {
        isFirstIn=YES;
        NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
        NSMutableArray *selfArray=[NSMutableArray array];
        [userDef setObject:selfArray  forKey:@"selfStocks"];
        [userDef setBool:isFirstIn forKey:@"isFirstIn"];
        
    }else{
        
    }
    _window.rootViewController=sideMenuViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
