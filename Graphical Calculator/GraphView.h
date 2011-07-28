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
    @private
    CGFloat scale; // Added in Lecture 8 to handle pinch
    id <GraphViewDelegate> delegate;
    CGPoint origin;
}

- (void)zoomIn;
- (void)zoomOut;

- (void)loadOrigin;
- (void)loadScale;

//- (void)saveState;

@property (assign) id <GraphViewDelegate> delegate;

@end
