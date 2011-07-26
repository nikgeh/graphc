//
//  GraphView.m
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"
#import "GraphDrawer.h"

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@synthesize delegate;

- (void)setup 
{
    // Makes the face a proper circle even when you rotate
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib 
{
    [self setup];
}

+ (BOOL)scaleIsValid:(CGFloat)aScale 
{
    return ((aScale > 0.0) && (aScale <= 1000.0));
}

#define DEFAULT_SCALE 10.0
#define SCALE_STEP 1.00

- (void)zoomIn
{
    self.scale += SCALE_STEP;    
}


- (void)zoomOut
{
    self.scale -= SCALE_STEP;
}


- (CGFloat)scale 
{
    return [GraphView scaleIsValid:scale] ? scale : DEFAULT_SCALE;
}

- (void)setScale:(CGFloat)newScale 
{
    if ([GraphView scaleIsValid:newScale]) {
        if (newScale != scale) {
            scale = newScale;
            [self setNeedsDisplay];
        }
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture 
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}



- (void)drawRect:(CGRect)rect
{
    // Draw axes
    CGRect axesBounds = self.bounds;
    CGPoint midPoint;
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    [AxesDrawer drawAxesInRect:axesBounds originAtPoint:midPoint scale:self.scale];
    
    // Plot the graph
    CGFloat scaleFactor = [self respondsToSelector:@selector(contentScaleFactor)] ? 
    self.contentScaleFactor : 1.0;
    [GraphDrawer drawGraphInRect:axesBounds originAtPoint:midPoint scale:self.scale
       contentScaleFactor:scaleFactor graphViewDelegate:self.delegate];

}         
         
- (void)dealloc
{
    [super dealloc];
}

@end
