//
//  Graphical_CalculatorAppDelegate.h
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Graphical_CalculatorAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *navCon;
    UISplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (retain) UINavigationController *navCon;
@property (retain) UISplitViewController *splitViewController;
@end
