//
//  ACBloodtrailAnimation.h
//  Halloween
//
//  Created by Arnaud Coomans on 27/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACBloodtrailDelegate.h"
#import "ACAnimation.h"

@interface ACBloodtrailAnimation : UIView <ACAnimation>

@property (nonatomic, assign) id <ACBloodtrailDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign) CGFloat animationSpeed;

- (id)initWithFrame:(CGRect)frame animationSpeed:(CGFloat)speed;

@end