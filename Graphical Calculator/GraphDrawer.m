//
//  GraphDrawer.m
//  Graphical Calculator
//
//  Created by Nik on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphDrawer.h"

@implementation GraphDrawer


+ (double)getXCoordFromPoint:(CGFloat)pointX pointXAtZero:(CGFloat)midX 
                       scale:(CGFloat)pointsPerUnit
{
    return (pointX-midX)/pointsPerUnit;
}

+ (CGPoint)getPointFromCoord:(CGRect)rect x:(CGFloat)x y:(CGFloat)y
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

+ (double) getYCoordFromXCoord:(double)x graphViewDelegate:(id<GraphViewDelegate>)delegate
{
    return [delegate resultForVariable:x];
}


+ (void)drawGraphInRect:(CGRect)graphBounds originAtPoint:(CGPoint)graphOrigin 
                  scale:(CGFloat)pointsPerUnit
     contentScaleFactor:(CGFloat)scaleFactor
      graphViewDelegate:(id<GraphViewDelegate>)delegate
{
    // Plot the graph
    CGRect plotBounds = graphBounds;    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    [[UIColor blueColor] setStroke];
    
    CGContextSetLineWidth(context, 5.0);
    
    CGContextBeginPath(context);
    
    CGFloat maxPointX = plotBounds.origin.x + plotBounds.size.width;
    BOOL firstLine = YES;
    
    CGFloat pointIncrement = 1.0/scaleFactor;
    for (CGFloat pointX = plotBounds.origin.x; pointX < maxPointX; pointX+= pointIncrement) {
        double xCoord = [self getXCoordFromPoint:pointX pointXAtZero:graphOrigin.x 
                                           scale:pointsPerUnit];
        double yCoord = [self getYCoordFromXCoord:xCoord graphViewDelegate:delegate];
        
        CGPoint point = [self getPointFromCoord:plotBounds x:xCoord y:yCoord scale:pointsPerUnit];
        
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

@end
