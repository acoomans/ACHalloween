//
//  ACFingerprintsView.m
//  ACHalloween
//
//  Created by Arnaud Coomans on 10/19/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACFingerprintsView.h"
#import "ACFingerprintAnimation.h"

@implementation ACFingerprintsView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    ACFingerprintAnimation *fingerprint = [[ACFingerprintAnimation alloc] initWithCenter:touchLocation];
    fingerprint.delegate = self.delegate;
    [self addSubview:fingerprint];
    [fingerprint startAnimating];
}

@end
