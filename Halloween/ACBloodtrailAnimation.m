//
//  ACBloodtrailAnimation.m
//  Halloween
//
//  Created by Arnaud Coomans on 27/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "ACBloodtrailAnimation.h"
#import <QuartzCore/QuartzCore.h>
//#import <objc/objc-runtime.h>

static const float kACBloodtrailViewBloodAnimationDuration = 5;
static const float kACBloodtrailViewTrailingAnimationDuration = 2;
static const float kACBloodtrailViewFadeOutAnimationDuration = 0.5;
static const float kACBloodtrailViewXOffset = -54;
static const float kACBloodtrailViewBloodHeight = 35;
static const float kACBloodtrailViewBloodWidth = 37;


@interface ACBloodtrailAnimation ()
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, retain) UIImageView *bloodStart;
@property (nonatomic, retain) UIImageView *bloodDrop;
@property (nonatomic, retain) NSArray *bloodtrails;
@property (nonatomic, assign) SEL stopTrailAnimationSelector;
@property (nonatomic, assign) BOOL isTrailAnimated;
- (UIImageView*)randomBlood;
- (void)addBlood:(UIView*)newBloodView toTrailWithLastBlood:(UIView*)lastBloodView;
- (void)bloodAnimation;
- (void)animateTrailWithLastBlood:(UIView*)lastBloodView;
- (BOOL)shouldStopTrailAnimation;
- (BOOL)shouldStopTrailAnimationIfFullHeight;
- (void)animateFadeOut;
- (void)addGestureRecognizerToBloodView:(UIView*)bloodView;
- (void)didStopAnimating;
@end

@implementation ACBloodtrailAnimation

- (id)initWithFrame:(CGRect)frame animationSpeed:(CGFloat)speed {
    self = [super initWithFrame:frame];
    if (self) {
		self.animationSpeed = speed;
        self.bloodtrails = @[
                             @"Halloween.bundle/Bloodtrail/bloodtrail0.png",
                             @"Halloween.bundle/Bloodtrail/bloodtrail1.png",
                             @"Halloween.bundle/Bloodtrail/bloodtrail2.png",
                             @"Halloween.bundle/Bloodtrail/bloodtrail3.png",
                             ];
		
		CGRect frame = self.frame;
		frame.size.width = kACBloodtrailViewBloodWidth;
		frame.origin.y -= 150;
        self.frame = frame;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame animationSpeed:1];
    return self;
}

- (void)didMoveToSuperview {
	CGRect frame = CGRectZero;
	
	self.bloodStart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Halloween.bundle/Bloodtrail/bloodtrail-start.png"]];
	frame = self.bloodStart.frame;
	frame.origin.x = kACBloodtrailViewXOffset;
	self.bloodStart.frame = frame;
	[self addSubview:self.bloodStart];
	
	float yOffset = frame.origin.y + frame.size.height;
	self.bloodDrop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Halloween.bundle/Bloodtrail/bloodtrail-drop.png"]];
	frame = self.bloodDrop.frame;
	frame.origin.y = yOffset;
	self.bloodDrop.frame = frame;
	[self addSubview:self.bloodDrop];
	
	[self addGestureRecognizerToBloodView:self.bloodStart];
	[self addGestureRecognizerToBloodView:self.bloodDrop];
}


#pragma mark - animation protocol

- (void)startAnimating {
	self.isAnimating = YES;
	[self bloodAnimation];
}

- (void)stopAnimating {
	self.isAnimating = NO;
	[self.layer removeAllAnimations];
	[self.bloodDrop.layer removeAllAnimations];
	[self.bloodStart.layer removeAllAnimations];
}

- (void)didStopAnimating {
	if (self.delegate && [self.delegate respondsToSelector:@selector(bloodtrailDidStop:)]) {
		[self.delegate bloodtrailDidStop:self];
	}
	[self animateFadeOut];
}

#pragma mark - drawing functions

- (UIImageView*)randomBlood {
	int index = arc4random() % [self.bloodtrails count];
	UIImage *image = [UIImage imageNamed:[self.bloodtrails objectAtIndex:index]];
	UIImageView *iv = [[UIImageView alloc] initWithImage:image];
	return iv;
}

- (void)addBlood:(UIView*)newBloodView toTrailWithLastBlood:(UIView*)lastBloodView {
	float yOffset = lastBloodView.frame.origin.y + lastBloodView.frame.size.height;
	CGRect frame = newBloodView.frame;
	frame.origin.y = yOffset;
	newBloodView.frame = frame;
	[self addSubview:newBloodView];
	[self addGestureRecognizerToBloodView:newBloodView];
}


#pragma mark - blood start animation

- (void)bloodAnimation {
	[UIView beginAnimations:@"ACBloodtrailViewBloodAnimation" context:nil];
	[UIView setAnimationDuration:kACBloodtrailViewBloodAnimationDuration / self.animationSpeed];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bloodAnimationDidStop:finished:context:)];
	
	CGRect frame = self.frame;
	frame.origin.y += 100;
	self.frame = frame;
	
	[UIView commitAnimations];
}

- (void)bloodAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if (!self.isAnimating) {
		[self didStopAnimating];
		return;
	}
	
	self.isTrailAnimated = YES;
	[self animateTrailWithLastBlood:self.bloodStart];
	if (self.delegate && [self.delegate respondsToSelector:@selector(bloodtrailDidStart:)]) {
		[self.delegate bloodtrailDidStart:self];
	}
}


#pragma mark - blood trail animation

- (void)animateTrailWithLastBlood:(UIView*)lastBloodView {
	
	UIImageView *newBloodView = [self randomBlood];
	[self addBlood:newBloodView toTrailWithLastBlood:lastBloodView];
	
	[UIView beginAnimations:@"ACBloodtrailViewTrailingAnimation" context:(__bridge void *)(newBloodView)];
	[UIView setAnimationDuration:kACBloodtrailViewTrailingAnimationDuration / self.animationSpeed];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(trailAnimationDidStop:finished:context:)];

	CGRect frame = self.bloodDrop.frame;
	frame.origin.y += 34;
	self.bloodDrop.frame = frame;
	
	[UIView commitAnimations];
}


- (void)trailAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	if (!self.isAnimating ||
        !self.isTrailAnimated ||
        [self shouldStopTrailAnimation]) {

		[self animateFadeOut];
		if (self.delegate && [self.delegate respondsToSelector:@selector(bloodtrailDidStop:)]) {
			[self.delegate bloodtrailDidStop:self];
		}
		return;
	}
	[self animateTrailWithLastBlood:(__bridge UIView *)(context)];
}


- (BOOL)shouldStopTrailAnimation {
	/*
	//doc: http://www.red-sweater.com/blog/320/abusing-objective-c-with-class
	// untested
	if (self.delegate && [self.delegate respondsToSelector:self.stopTrailAnimationSelector]) {
		
		BOOL (*MyMagicSender)(id, SEL) =
		(BOOL (*)(id, SEL)) objc_msgSend;
		
		BOOL shouldStop = MyMagicSender(self.delegate, self.stopTrailAnimationSelector);
		return shouldStop;
	}
	*/
	return [self shouldStopTrailAnimationIfFullHeight];
}

- (BOOL)shouldStopTrailAnimationIfFullHeight {
	float trailHeight = [self.subviews count] * kACBloodtrailViewBloodHeight - 50;
	return (trailHeight > self.frame.size.height);
}

#pragma mark - fade out animation

- (void)animateFadeOut {
	[UIView beginAnimations:@"ACBloodtrailViewFadeOutAnimation" context:nil];
	[UIView setAnimationDuration:kACBloodtrailViewFadeOutAnimationDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadeOutAnimationDidStop:finished:context:)];
	self.alpha = 0.0;	
	[UIView commitAnimations];
}


- (void)fadeOutAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidEnd:)]) {
		[self.delegate animationDidEnd:self];
	}
    [self removeFromSuperview];
}


#pragma mark - gesture recognizers

- (void)addGestureRecognizerToBloodView:(UIView*)bloodView {
	bloodView.userInteractionEnabled = YES;
	UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	[bloodView addGestureRecognizer:swipeGestureRecognizer];
	[bloodView addGestureRecognizer:tapGestureRecognizer];
}
												   
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
	gestureRecognizer.view.hidden = YES;
	
	if (gestureRecognizer.view == self.bloodDrop) {
		self.isTrailAnimated = NO;
		[self didStopAnimating];
	}
}


@end
