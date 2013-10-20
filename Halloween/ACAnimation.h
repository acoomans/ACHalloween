//
//  ACAnimation.h
//  Halloween
//
//  Created by Arnaud Coomans on 28/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ACAnimation <NSObject>

@required
- (void)startAnimating;
- (void)stopAnimating;
- (void)isAnimating;

- (void)setDelegate:(id)delegate;
- (id)delegate;

- (void)setAnimationSpeed:(CGFloat)speed;
- (CGFloat)animationSpeed;

@end
