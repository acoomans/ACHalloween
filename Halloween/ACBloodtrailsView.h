//
//  ACBloodtrailsView.h
//  Halloween
//
//  Created by Arnaud Coomans on 28/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACBloodtrailDelegate.h"
#import "ACAnimation.h"

@interface ACBloodtrailsView : UIView <ACAnimation>

@property (nonatomic, assign) id <ACBloodtrailDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign) CGFloat animationSpeed;
@property (nonatomic, assign) NSUInteger trailsCount;

- (id)initWithTrailsCount:(NSUInteger)count;

@end
