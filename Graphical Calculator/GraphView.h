//
//  GraphView.h
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewDelegate.h"

@interface GraphView : UIView {
    CGFloat scale; // Added in Lecture 8 to handle pinch
    id <GraphViewDelegate> delegate;
}

- (void)zoomIn;
- (void)zoomOut;


@property CGFloat scale;
@property (assign) id <GraphViewDelegate> delegate;

@end
