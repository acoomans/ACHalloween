//
//  ACFingerprintAnimation.h
//  Halloween
//
//  Created by Arnaud Coomans on 27/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACAnimation.h"
#import "ACAnimationDelegate.h"

@interface ACFingerprintAnimation : UIImageView <ACAnimation>

@property (nonatomic, weak) id <ACAnimationDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign) CGFloat animationSpeed;

- (id)initWithCenter:(CGPoint)center;
- (id)initWithCenter:(CGPoint)center animationSpeed:(CGFloat)speed;

@end
