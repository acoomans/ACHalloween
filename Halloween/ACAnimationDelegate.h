//
//  ACAnimationDelegate.h
//  Halloween
//
//  Created by Arnaud Coomans on 28/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACAnimation.h"

@protocol ACAnimationDelegate <NSObject>

@optional
- (void)animationDidEnd:(id<ACAnimation>)animation;

@end
