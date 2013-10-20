//
//  ACAppDelegate.m
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 31/08/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACTableViewController.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    ACTableViewController *tableViewController = [[ACTableViewController alloc] initWithNibName:NSStringFromClass([ACTableViewController class])
                                                                                         bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    navigationController.navigationBar.translucent = NO;

    if (SYSTEM_VERSION_EQUAL_TO_OR_GREATER_THAN(@"7.0")) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor halloweenColor]];
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    } else {
        navigationController.navigationBar.tintColor = [UIColor halloweenColor];
    }

    self.window.rootViewController = navigationController;
    return YES;
}

@end
