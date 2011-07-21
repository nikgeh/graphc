//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Nik on 6/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"
#import "GraphViewController.h"

@interface CalculatorViewController : UIViewController {
    CalculatorBrain *brain;
    GraphViewController *internalGraphViewController;
    IBOutlet UILabel *display;
    BOOL isTypingNumber;
}

@property (readonly) GraphViewController *graphViewController;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)variablePressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)solveExpression:(id)sender;

@end
