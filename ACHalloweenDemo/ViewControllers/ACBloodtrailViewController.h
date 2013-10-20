//
//  ACBloodtrailViewController.h
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 10/19/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACBloodtrailsView.h"

@interface ACBloodtrailViewController : UIViewController

@property (nonatomic, weak) IBOutlet ACBloodtrailsView* bloodtrailsView;
- (IBAction)animationButtonTapped:(id)sender;

@end
