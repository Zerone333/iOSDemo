//
//  AppDelegate.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "YZMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#if DEBUG
    // iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    // tvOS
    //    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
    // macOS
    //    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
    
    
#endif
    YZMainViewController *vc = [[YZMainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
