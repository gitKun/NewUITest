//
//  DRLineProgressView.m
//  DRLineProgress
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "DRLineProgressView.h"
#import "DRLineProgressLayer.h"

@implementation DRLineProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (void)_defaultInit {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    self.total = 100;
    self.color = [UIColor clearColor];
    self.completed = 0;
    self.completedColor = [UIColor whiteColor];
    
    self.radius = 30.0;
    self.innerRadius = 20.0;
    
    self.startAngle = 0;
    self.endAngle = M_PI*2;
}

+ (Class)layerClass {
    return [DRLineProgressLayer class];
}

- (void)setTotal:(int)total
{
    _total = total;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.total = total;
    [layer setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.color = color;
    [layer setNeedsDisplay];
}

- (void)setCompletedColor:(UIColor *)completedColor {
    _completedColor = completedColor;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.completedColor = completedColor;
    [layer setNeedsDisplay];
}

-(void)setCompleted:(int)completed {
    [self setCompleted:completed animated:NO];
}

- (void)setCompleted:(int)completed animated:(BOOL)animated {
    if (completed == self.completed) {
        return;
    }
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    if (animated && self.animationDuration > 0.0f) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"completed"];
        animation.duration = self.animationDuration;
        animation.fromValue = [NSNumber numberWithFloat:self.completed];
        animation.toValue = [NSNumber numberWithFloat:completed];
        animation.delegate = self;
        [self.layer addAnimation:animation forKey:@"currentAnimation"];
    }
    layer.completed = completed;
    [layer setNeedsDisplay];
}


- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.radius = radius;
    [layer setNeedsDisplay];
}

- (void)setInnerRadius:(CGFloat)innerRadius {
    _innerRadius = innerRadius;
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.innerRadius = innerRadius;
    [layer setNeedsDisplay];
}

- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.startAngle = startAngle;
    [layer setNeedsDisplay];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.endAngle = endAngle;
    [layer setNeedsDisplay];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    DRLineProgressLayer *layer = (DRLineProgressLayer *)self.layer;
    layer.animationDuration = animationDuration;
    [layer setNeedsDisplay];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(LineProgressViewAnimationDidStart:)]) {
        [self.mDelegate LineProgressViewAnimationDidStart:self];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(LineProgressViewAnimationDidStop:)]) {
        [self.mDelegate LineProgressViewAnimationDidStop:self];
    }
}

@end

