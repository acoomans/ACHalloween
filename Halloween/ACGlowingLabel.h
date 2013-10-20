//
//  ACGlowingLabel.h
//  Halloween
//
//  Created by Arnaud Coomans on 26/09/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACGlowingLabel : UILabel
@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign) CGFloat animationDuration;

- (void)startAnimating;
- (void)stopAnimating;

@end
