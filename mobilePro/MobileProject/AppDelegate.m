//
//  AppDelegate.m
//  MobileProject
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "AppDelegate.h"
#import "TestRacViewController.h"
#import "RACSignalTestViewController.h"
#import "RACChannelViewController.h"
#import "MulticastConnectionViewController.h"
#import "MPTTableViewController.h"

#import "MPBaseViewModelServicesImpl.h"
#import "MPHomePageViewModel.h"

@interface AppDelegate ()

@property (nonatomic, strong) MPBaseViewModelServicesImpl *services;
@property (nonatomic, strong) MPBaseViewModel *viewModel;
@property (nonatomic, strong, readwrite) MPNavigationControllerStack *navigationControllerStack;

@property (assign , nonatomic , readwrite) ReachabilityStatus  NetWorkStatus;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //日志初始化
    [MyFileLogger sharedManager];
    [self configurationNetWorkStatus];
    
    //初始化
    self.services = [[MPBaseViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[MPNavigationControllerStack alloc] initWithServices:self.services];
    
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.services resetRootViewModel:[self createInitialViewModel]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (MPBaseViewModel *)createInitialViewModel {
    // The user has logged-in.
//    if (YES) {
        return [[MPHomePageViewModel alloc] initWithServices:self.services params:nil];
//    } else {
//        return [[MPLoginViewModel alloc] initWithServices:self.services params:nil];
//    }
}

- (void)configurationNetWorkStatus
{
    
    [GLobalRealReachability startNotifier];
    
    RAC(self, NetWorkStatus) = [[[[[NSNotificationCenter defaultCenter]
                                   rac_addObserverForName:kRealReachabilityChangedNotification object:nil]
                                  map:^(NSNotification *notification) {
                                      return @([notification.object currentReachabilityStatus]);
                                  }]
                                 startWith:@([GLobalRealReachability currentReachabilityStatus])]
                                distinctUntilChanged];
    
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
