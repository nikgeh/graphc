//
//  GraphDrawer.h
//  Graphical Calculator
//
//  Created by Nik on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphView.h"

@interface GraphDrawer : NSObject {
    
}

+ (void)drawGraphInRect:(CGRect)graphBounds originAtPoint:(CGPoint)graphOrigin 
                  scale:(CGFloat)pointsPerUnit
     contentScaleFactor:(CGFloat)scaleFactor
      graphViewDelegate:(id<GraphViewDelegate>)delegate;


@end
