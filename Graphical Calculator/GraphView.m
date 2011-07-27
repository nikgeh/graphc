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

#import "GraphUserPreference.h"

@interface GraphView()

- (void)resetOrigin;

@property (nonatomic) CGPoint origin;
@property CGFloat scale;

@end


@implementation GraphView

@synthesize origin;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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

- (CGPoint)midPoint
{
	return CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,
                       self.bounds.origin.y + self.bounds.size.height/2);
}

- (void)resetOrigin
{
	self.origin = [self midPoint];
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

- (void)loadScale
{
    self.scale = [GraphUserPreference getScale];
}

- (void)saveScale
{
    [GraphUserPreference setScale:self.scale];
}

- (void)setOrigin:(CGPoint)newPoint 
{
    origin = newPoint;
    [self setNeedsDisplay];
}

- (void)loadOrigin
{
    if ([GraphUserPreference hasOriginPosition]) {
        self.origin = [GraphUserPreference getOriginPosition];        
    } else {
        self.origin = [self midPoint];
    }
}

- (void)saveOrigin
{
    [GraphUserPreference setOriginPosition:self.origin];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture 
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self saveScale];
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture 
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self];
        self.origin = CGPointMake(self.origin.x + translation.x, self.origin.y + translation.y);
        [gesture setTranslation:CGPointZero inView:self];
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self saveOrigin];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture 
{
    [self resetOrigin];
    [self saveOrigin];
}

- (void)drawRect:(CGRect)rect
{
    // Draw axes
    CGRect axesBounds = self.bounds;

    // Draw the axes
    [AxesDrawer drawAxesInRect:axesBounds originAtPoint:self.origin scale:self.scale];
    
    // Plot the graph
    CGFloat scaleFactor = [self respondsToSelector:@selector(contentScaleFactor)] ? 
    self.contentScaleFactor : 1.0;
    [GraphDrawer drawGraphInRect:axesBounds originAtPoint:self.origin scale:self.scale
       contentScaleFactor:scaleFactor graphViewDelegate:self.delegate];

}         
         
- (void)dealloc
{
    [super dealloc];
}

@end
