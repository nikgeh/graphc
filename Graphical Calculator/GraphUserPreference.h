//
//  GraphUserPreference.h
//  Graphical Calculator
//
//  Created by Nik on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphUserPreference : NSObject {
    
}

// I miss Java generics... sigh... 

+ (CGPoint)getOriginPosition;
+ (void)setOriginPosition:(CGPoint)point;
+ (BOOL)hasOriginPosition;

+ (CGFloat)getScale;
+ (void)setScale:(CGFloat)scale;

@end
