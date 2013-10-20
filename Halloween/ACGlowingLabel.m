//
//  ACGlowingLabel.m
//  Halloween
//
//  Created by Arnaud Coomans on 26/09/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "ACGlowingLabel.h"
#import <QuartzCore/QuartzCore.h>

static const float ACGlowingLabelGlowDefaultAnimationDuration = 1.2;

@interface ACGlowingLabel ()
- (void)animateGlow;
@end

@implementation ACGlowingLabel

- (id)init {
    self = [super init];
    if (self) {
        self.animationDuration = ACGlowingLabelGlowDefaultAnimationDuration;
    }
    return self;
}


- (void)startAnimating {
	if (self.isAnimating) return;
	_isAnimating = YES;
	[self animateGlow];
}

- (void)stopAnimating {
	if (!self.isAnimating) return;
	[self.layer removeAllAnimations];
	_isAnimating = NO;
}


- (void)animateGlow {
	self.alpha = 0.0;
	[UIView animateWithDuration:self.animationDuration > 0 ? self.animationDuration : ACGlowingLabelGlowDefaultAnimationDuration
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseOut
					 animations:^{ self.alpha = 1.0; }
					 completion:nil
	 ];
}

@end
