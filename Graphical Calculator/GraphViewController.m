//
//  GraphViewController.m
//  Graphical Calculator
//
//  Created by Nik on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController

@synthesize delegate;
@synthesize graphView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)releaseOutlets
{
    self.graphView = nil;
}

- (void)dealloc
{
    [self releaseOutlets];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)updateUI 
{
    [self.graphView setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.graphView.delegate = self.delegate;
    
    // Set up pinch recognizer
    /*UIGestureRecognizer *pinchGr = [[UIPinchGestureRecognizer alloc] 
                                    initWithTarget:self.graphView 
                                    action:@selector(pinch:)];
    [self.graphView addGestureRecognizer:pinchGr];
    [pinchGr release];
    [self updateUI];*/

}

- (void)viewDidUnload
{
    [self releaseOutlets];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)zoomIn:(UIButton *)sender 
{
    [self.graphView zoomIn];
    [self.graphView setNeedsDisplay];
}

- (IBAction)zoomOut:(UIButton *)sender 
{
    [self.graphView zoomOut];
    [self.graphView setNeedsDisplay];
}

@end
