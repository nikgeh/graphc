//
//  GraphView.m
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer/AxesDrawer.h"

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

- (double)getXCoordFromPoint:(CGFloat)pointX pointXAtZero:(CGFloat)midX 
                       scale:(CGFloat)pointsPerUnit
{
    return (pointX-midX)/pointsPerUnit;
}

- (CGPoint)getPointFromCoord:(CGRect)rect x:(CGFloat)x y:(CGFloat)y
                       scale:(CGFloat)pointsPerUnit
{
    CGPoint point;
    CGPoint midPoint;
	midPoint.x = rect.origin.x + rect.size.width/2;
	midPoint.y = rect.origin.y + rect.size.height/2;
    
    point.x = x*pointsPerUnit + midPoint.x + rect.origin.x;
    CGFloat yVal = y*pointsPerUnit + midPoint.y;
    point.y = rect.origin.y + rect.size.height - yVal;
    
    return point;
}

- (double) getYCoordFromXCoord:(double) x
{
    return [self.delegate resultForVariable:x];
    //return sin(x);
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
    CGRect plotBounds = self.bounds;    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    [[UIColor blueColor] setStroke];

    CGContextSetLineWidth(context, 5.0);

    CGContextBeginPath(context);
    
    CGFloat maxPointX = plotBounds.origin.x + plotBounds.size.width;
    BOOL firstLine = YES;
    CGFloat pointIncrement = 1.0/self.contentScaleFactor;
    for (CGFloat pointX = plotBounds.origin.x; pointX < maxPointX; pointX+= pointIncrement) {
        double xCoord = [self getXCoordFromPoint:pointX pointXAtZero:midPoint.x scale:self.scale];
        double yCoord = [self getYCoordFromXCoord:xCoord];
        
        CGPoint point = [self getPointFromCoord:plotBounds x:xCoord y:yCoord scale:self.scale];

        if (firstLine) {
            firstLine = NO;
        } else {
            CGContextAddLineToPoint(context, point.x, point.y);
            CGContextStrokePath(context);
        }
        CGContextMoveToPoint(context, point.x, point.y);
        
    }

    UIGraphicsPopContext();

}

         
         
- (void)dealloc
{
    [super dealloc];
}

@end
