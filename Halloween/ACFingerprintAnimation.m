//
//  ACFingerprintAnimation.m
//  Halloween
//
//  Created by Arnaud Coomans on 27/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "ACFingerprintAnimation.h"
#import <QuartzCore/QuartzCore.h>


static const float kACFingerprintViewFadeOutAnimationDuration = 2.0;
static const float kACFingerprintViewWidth = 100;
static const float kACFingerprintViewHeight = 100;

@interface ACFingerprintAnimation ()
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, retain) NSArray *fingerprintImages;
- (id)initWithFrame:(CGRect)frame animationSpeed:(CGFloat)speed;
- (id)initAtOrigin:(CGPoint)origin;
- (void)animateFadeOut;
@end

@implementation ACFingerprintAnimation

- (id)initWithFrame:(CGRect)frame animationSpeed:(CGFloat)speed {
    self = [super initWithFrame:frame];
    if (self) {
		self.frame = CGRectMake(frame.origin.x,
                                frame.origin.y,
                                kACFingerprintViewWidth,
                                kACFingerprintViewHeight);
		self.fingerprintImages = @[
                                   @"Halloween.bundle/Fingerprints/fingerprint0.png",
                                   @"Halloween.bundle/Fingerprints/fingerprint1.png",
                                   ];
		self.animationSpeed = speed;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame animationSpeed:1];
    return self;
}

- (id)initAtOrigin:(CGPoint)origin {
    self = [self initWithFrame:CGRectMake(origin.x,
                                          origin.y,
                                          kACFingerprintViewWidth,
                                          kACFingerprintViewHeight)];
    return self;
}

- (id)initWithCenter:(CGPoint)center {
    self = [self initWithFrame:CGRectMake(center.x-kACFingerprintViewWidth/2,
                                          center.y-kACFingerprintViewHeight/2,
                                          kACFingerprintViewWidth,
                                          kACFingerprintViewHeight)];
    return self;
}

- (id)initWithCenter:(CGPoint)center animationSpeed:(CGFloat)speed {
    self = [self initWithFrame:CGRectMake(center.x-kACFingerprintViewWidth/2,
                                          center.y-kACFingerprintViewHeight/2,
                                          kACFingerprintViewWidth,
                                          kACFingerprintViewHeight)
                animationSpeed:speed];
    return self;
}


- (void)didMoveToSuperview {
    if (!self.image) {
        self.image = [self randomFingerprintImage];
        self.alpha = 0.2;
    }
}

#pragma mark - fingerprint images

- (UIImage*)randomFingerprintImage {
    int index = arc4random() % [self.fingerprintImages count];
    return [UIImage imageNamed:[self.fingerprintImages objectAtIndex:index]];
}

#pragma mark - animation protocol

- (void)startAnimating {
	self.isAnimating = YES;
	[self animateFadeOut];
}

- (void)stopAnimating {
	self.isAnimating = NO;
	[self.layer removeAllAnimations];
}

#pragma mark - fade out animation

- (void)animateFadeOut {
	[UIView beginAnimations:@"ACFingerprintViewFadeOutAnimation" context:nil];
	[UIView setAnimationDuration:kACFingerprintViewFadeOutAnimationDuration / self.animationSpeed];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadeOutAnimationDidStop:finished:context:)];
	self.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)fadeOutAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([self.delegate respondsToSelector:@selector(animationDidEnd:)]) {
		[self.delegate animationDidEnd:self];
	}
    [self removeFromSuperview];
}

@end
