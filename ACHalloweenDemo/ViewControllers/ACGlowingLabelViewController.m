//
//  ACViewController.m
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 31/08/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACGlowingLabelViewController.h"

@interface ACGlowingLabelViewController ()
@end

@implementation ACGlowingLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Glowing Label";

    [self.glowingLabel startAnimating];
}

- (IBAction)animationButtonTapped:(id)sender {
    if ([self.glowingLabel isAnimating]) {
        self.button.selected = YES;
        [self.glowingLabel stopAnimating];
    } else {
        self.button.selected = NO;
        [self.glowingLabel startAnimating];
    }
}

@end
