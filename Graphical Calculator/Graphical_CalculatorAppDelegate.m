//
//  Graphical_CalculatorAppDelegate.m
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Graphical_CalculatorAppDelegate.h"
#import "CalculatorViewController.h"

@implementation Graphical_CalculatorAppDelegate

- (BOOL) iPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


@synthesize window=_window;
@synthesize navCon;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // This root controller is never freed, so we don't usually have to dealloc it
    navCon = [[UINavigationController alloc] init];
    
    CalculatorViewController *cvc = [[CalculatorViewController alloc] init];
    [navCon pushViewController:cvc animated:NO];

    if (self.iPad) {
        // Create a right nav section: 
        // Left = CalculatorViewController 
        // Right = GraphViewController
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        UINavigationController *rightNav = [[UINavigationController alloc] init];
        [rightNav pushViewController:cvc.graphViewController animated:NO];
        svc.delegate = cvc.graphViewController;
        svc.viewControllers = [NSArray arrayWithObjects:navCon, rightNav, nil];
        
        // Release these 2 controllers, because the split-view controller owns them now
        [navCon release]; 
        [rightNav release];
        
        [self.window addSubview:svc.view];
    } else {
        [self.window addSubview:navCon.view];
    }
    [cvc release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [navCon release];
    [super dealloc];
}

@end
