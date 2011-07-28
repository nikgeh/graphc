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
    UIGestureRecognizer *pinchGr = [[UIPinchGestureRecognizer alloc] 
                                    initWithTarget:self.graphView 
                                    action:@selector(pinch:)];
    [self.graphView addGestureRecognizer:pinchGr];
    [pinchGr release];
    
    UIGestureRecognizer *panGr = [[UIPanGestureRecognizer alloc] 
                                    initWithTarget:self.graphView 
                                    action:@selector(pan:)];
    [self.graphView addGestureRecognizer:panGr];
    [panGr release];

    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] 
                                  initWithTarget:self.graphView 
                                  action:@selector(tap:)];
    tapGr.numberOfTapsRequired = 2;
    [self.graphView addGestureRecognizer:tapGr];
    [tapGr release];

    [self updateUI];
}

- (void)viewDidUnload
{
    [self releaseOutlets];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.graphView loadOrigin];
    [self.graphView loadScale];
    [self updateUI];
}

/*- (void)viewDidAppear:(BOOL)animated
{
}*/

- (void)updateGraph
{
    [self updateUI];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark UISplitViewControllerDelegate

/**
 Called when we are in landscape mode on the iPad
 */
- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button {
    self.navigationItem.rightBarButtonItem = nil;
}

/**
 Called when we are in portrait mode on the iPad
 */
- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    barButtonItem.title = aViewController.title;
    self.navigationItem.rightBarButtonItem = barButtonItem;
}


@end
