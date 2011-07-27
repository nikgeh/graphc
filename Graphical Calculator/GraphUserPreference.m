//
//  GraphUserPreference.m
//  Graphical Calculator
//
//  Created by Nik on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphUserPreference.h"

//#define GRAPH_PREFERENCE_KEY @"graphPreferenceKey"
#define ORIGIN_POSITION @"originPosition"
#define SCALE_PREFERENCE @"scalePreference"

@implementation GraphUserPreference

+ (CGPoint)getOriginPosition
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    return CGPointFromString([d stringForKey:ORIGIN_POSITION]);
}

+ (void)setOriginPosition:(CGPoint)point
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    [d setValue:NSStringFromCGPoint(point) forKey:ORIGIN_POSITION];
    [d synchronize];
}

+ (BOOL)hasOriginPosition
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:ORIGIN_POSITION] != nil;
}

+ (CGFloat)getScale
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:SCALE_PREFERENCE];
}

+ (void)setScale:(CGFloat)scale
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    [d setFloat:scale forKey:SCALE_PREFERENCE];
    [d synchronize];
}

@end
