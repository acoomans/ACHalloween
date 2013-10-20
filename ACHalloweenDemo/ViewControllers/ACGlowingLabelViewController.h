//
//  ACViewController.h
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 31/08/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACGlowingLabel.h"

@interface ACGlowingLabelViewController : UIViewController

@property (nonatomic, weak) IBOutlet ACGlowingLabel *glowingLabel;
@property (nonatomic, weak) IBOutlet UIButton *button;
- (IBAction)animationButtonTapped:(id)sender;

@end
