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

+ (CGPoint)getPointFromCoord:(CGRect)rect origin:(CGPoint)origin x:(CGFloat)x y:(CGFloat)y
                       scale:(CGFloat)pointsPerUnit
{
    return CGPointMake(x*pointsPerUnit + origin.x + rect.origin.x, 
                       rect.origin.y + origin.y - y*pointsPerUnit);    
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
        
        CGPoint point = [self getPointFromCoord:plotBounds origin:graphOrigin 
                                              x:xCoord y:yCoord scale:pointsPerUnit];
        
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
