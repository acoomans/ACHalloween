//
//  ACBloodtrailDelegate.h
//  Halloween
//
//  Created by Arnaud Coomans on 28/08/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACAnimationDelegate.h"

@class ACBloodtrailAnimation;

@protocol ACBloodtrailDelegate <ACAnimationDelegate>

@optional
- (void)bloodtrailDidStart:(ACBloodtrailAnimation*)bloodtrail;
- (void)bloodtrailDidStop:(ACBloodtrailAnimation*)bloodtrail;

@end
