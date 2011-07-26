//
//  GraphViewController.h
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController<UISplitViewControllerDelegate> {
    IBOutlet GraphView *graphView;
    id <GraphViewDelegate> delegate;
}

@property (retain) IBOutlet GraphView *graphView;
@property (assign) id <GraphViewDelegate> delegate;

- (void)updateGraph;

@end
