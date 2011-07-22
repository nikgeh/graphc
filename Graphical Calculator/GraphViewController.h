//
//  GraphViewController.h
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController<GraphViewDelegate> {
    
    IBOutlet GraphView *graphView;
}

@property (retain) IBOutlet GraphView *graphView;

- (IBAction)zoomIn:(UIButton *)sender;
- (IBAction)zoomOut:(UIButton *)sender;

@end
