//
//  ACBloodtrailViewController.m
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 10/19/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACBloodtrailViewController.h"
#import "ACBloodtrailAnimation.h"

@interface ACBloodtrailViewController ()
@end

@implementation ACBloodtrailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bloodtrail";
    
    /*
    ACBloodtrailAnimation *trail;

    CGFloat xOffset = arc4random() % (int) self.view.frame.size.width;
    CGFloat yOffset = arc4random() % 10;

    trail = [[ACBloodtrailAnimation alloc] initWithFrame:CGRectMake(xOffset, -yOffset, self.view.frame.size.height, self.view.frame.size.width)
                                     animationSpeed:(5.0 + (arc4random()%15))/10.0 *1];

    [self.view addSubview:trail];
    
    [trail startAnimating];
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.bloodtrailsView.trailsCount = 5;
    [self.bloodtrailsView startAnimating];
}

- (IBAction)animationButtonTapped:(id)sender {
    [self.bloodtrailsView startAnimating];
}

@end
