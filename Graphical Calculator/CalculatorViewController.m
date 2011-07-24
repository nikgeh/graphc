//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nik on 6/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
- (void)initComponents;
- (void)releaseComponents;
- (void)solveExpressionWithVariables;
- (void)solveExpressionWithoutVariables;

@property (retain) CalculatorBrain *brain;
@end


@implementation CalculatorViewController
@synthesize brain;

- (GraphViewController *) graphViewController {
    // Lazy load
    if (!internalGraphViewController) {
        internalGraphViewController = [[GraphViewController alloc] init];
        internalGraphViewController.delegate = self;
    }
    return internalGraphViewController;
}

- (void)initComponents
{
    CalculatorBrain *calcBrain = [[CalculatorBrain alloc] init];
    brain = [[CalculatorBrain alloc] init];
    [calcBrain release];
}

- (void)releaseComponents
{
    brain = nil;
    [internalGraphViewController release];
}

- (void)updateDisplayWithResult:(NSDictionary *)variableValues
{
    display.text = [NSString stringWithFormat:@"%g",
                    [CalculatorBrain evaluateExpression:brain.expression
                                    usingVariableValues:nil]];     
}

/**
 Updates the display with the value of the evaluated expression
 */
- (void)updateDisplayWithExpression
{
    if ([CalculatorBrain variablesInExpression:brain.expression]) {
        display.text = [CalculatorBrain descriptionOfExpression:brain.expression];
    } else {
        [self updateDisplayWithResult:nil];
    }
}


- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digitString = [sender.titleLabel text];
    if (isTypingNumber) {
        // Append the number to whatever's in the display
        display.text = [display.text stringByAppendingString:digitString];
    } else {
        [display setText:digitString];
        isTypingNumber = YES;
    }
}

- (IBAction)variablePressed:(UIButton *)sender
{
    if (!isTypingNumber) {        
        [brain setVariableAsOperand:sender.titleLabel.text];
        [self updateDisplayWithExpression];
    }
}

- (void)flushNumber
{
    // Update the operand to the number the the user has currently typed so far
    [brain setOperand:[display.text doubleValue]];
    isTypingNumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (isTypingNumber) {
        [self flushNumber];
    }
    NSString *operation = [[sender titleLabel] text];
    /*double result = */[brain performOperation:operation];
    //[display setText:[NSString stringWithFormat:@"%g", result]];
    [self updateDisplayWithExpression];
}

- (IBAction)clearPressed:(UIButton *)sender
{
    [brain clearCalculator];
    isTypingNumber = NO;
    display.text = @"0";
}


- (IBAction)solveExpression:(id)sender 
{    
    if (isTypingNumber) {
        [self flushNumber];
    }
    [self.brain terminateExpressionWithEquals];
    if ([CalculatorBrain variablesInExpression:brain.expression]) {
        [self solveExpressionWithVariables];
    } else {
        [self solveExpressionWithoutVariables];
    }
}

- (void)solveExpressionWithoutVariables
{
    NSString *expression = [CalculatorBrain descriptionOfExpression:brain.expression];
    NSMutableString *sb = [[NSMutableString alloc] initWithString:expression];
    [sb appendString:@" "];
    
    double result = [CalculatorBrain evaluateExpression:brain.expression
                                    usingVariableValues:nil];

    [sb appendString:[NSString stringWithFormat:@"%g", result]];
    display.text = sb;
    [sb release];
}

- (void)solveExpressionWithVariables
{
    // Slide in Graph View Controller
    GraphViewController *gvc = self.graphViewController;
    gvc.title = [NSString stringWithFormat:@"%@", [CalculatorBrain descriptionOfExpression:self.brain.expression]];
    if (gvc.view.window == nil) {
        [self.navigationController pushViewController:gvc animated:YES];
    } else {
        [gvc updateGraph];
    }
}


- (void)dealloc
{
    [self releaseComponents];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // Initialize the brain
    [self initComponents];
    self.title = @"Calculator";
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self releaseComponents];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


#pragma mark - Protocol GraphViewDelegate

- (double)resultForVariable:(double) x
{
    
    NSMutableDictionary *expressionsDict = [[NSMutableDictionary alloc] init];
    // TODO: Constant?
    [expressionsDict setValue:[NSNumber numberWithDouble:x] forKey:@"x"];
    
    double result = [CalculatorBrain evaluateExpression:self.brain.expression 
                                    usingVariableValues:expressionsDict];
    [expressionsDict release];
    return result;
}

@end
