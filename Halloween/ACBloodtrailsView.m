//
//  ACBloodtrailsView.m
//  Halloween
//
//  Created by Arnaud Coomans on 28/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "ACBloodtrailsView.h"
#import "ACBloodtrailAnimation.h"


@interface ACBloodtrailsView ()
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, retain) NSMutableArray *trails;
@end


@implementation ACBloodtrailsView

- (id)initWithTrailsCount:(NSUInteger)count {
    self = [super init];
    if (self) {
		self.trailsCount = count;
		self.trails = [NSMutableArray array];
    }
    return self;
}

- (id)init {
	self = [self initWithTrailsCount:5];
    return self;
}

#pragma mark - animation protocol

- (void)startAnimating {
	
	self.isAnimating = YES;
	float xOffset = 0;
	float yOffset = 0;
	ACBloodtrailAnimation *trail = nil;
	for (int i=0; i<self.trailsCount; i++) {
		
		xOffset = arc4random() % (int) self.frame.size.width;
		yOffset = arc4random() % 50;
		
		trail = [[ACBloodtrailAnimation alloc] initWithFrame:CGRectMake(xOffset,
                                                                        -yOffset,
                                                                        self.frame.size.height,
                                                                        self.frame.size.width)
                                              animationSpeed:(5.0 + (arc4random()%15))/10.0];
		trail.delegate = self.delegate;
		[self.trails addObject:trail];
		[self addSubview:trail];
		[trail startAnimating];
	}
}

- (void)stopAnimating {
	self.isAnimating = NO;
	[self.trails makeObjectsPerformSelector:@selector(stopAnimating)];
}

/*
- (void)bloodtrailDidDisappear {
	self.trailsCount--;
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidEnd:)]) {
		[self.delegate animationDidEnd:self];
	}
}
*/

@end
