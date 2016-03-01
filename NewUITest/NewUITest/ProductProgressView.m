//
//  ProductProgressView.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ProductProgressView.h"

const CGFloat innerSpacing = 8;

@interface ProductProgressLayer : CALayer

/** 圆环的背景色 */
@property(nonatomic, strong) UIColor *trackTintColor;
/** 当前进度的颜色 */
@property(nonatomic, strong) UIColor *progressTintColor;
/** 圆环的粗细 */
@property (nonatomic) CGFloat bigCircleWidth;
/** 圆环的颜色 */
@property (nonatomic, strong) UIColor *bigCircleColor;
/** 当前进度值 0.0~1.0 之间 */
@property(nonatomic) CGFloat progress;
/** 是否顺时针 0标示逆时针 !0标示是顺时针 */
@property(nonatomic) NSInteger clockwiseProgress;

@end

@implementation ProductProgressLayer

@dynamic trackTintColor;
@dynamic progressTintColor;
@dynamic bigCircleColor;
@dynamic progress;
@dynamic clockwiseProgress;

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

-(void)drawInContext:(CGContextRef)ctx {
    CGRect rect = self.bounds;
    CGPoint centerPoint = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGFloat radius = MIN(rect.size.height-innerSpacing, rect.size.width-innerSpacing) / 2.0f;
    CGFloat bigRadius = MIN(rect.size.height, rect.size.width) / 2.0f;
    
    BOOL clockwise = (self.clockwiseProgress != 0);
    //FLT_EPSILON 表示误差值(由编译器和CUP等决定) (可以看做 0.0)
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = 0;
    //这里要注意 画图的 角度开始点是在水平方向右顶点
    if (clockwise) {
        radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    } else {
        radians = (float)(3 * M_PI_2 - (progress * 2.0f * M_PI));
    }
    CGContextSetFillColorWithColor(ctx, self.trackTintColor.CGColor);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, bigRadius, (float)(2.0f * M_PI), 0.0f, TRUE);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(ctx, trackPath);
    CGContextFillPath(ctx);
    CGPathRelease(trackPath);
    
    if (progress > 0.0f) {
        CGContextSetFillColorWithColor(ctx, self.progressTintColor.CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, (float)(3.0f * M_PI_2), radians, !clockwise);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(ctx, progressPath);
        CGContextFillPath(ctx);
        CGPathRelease(progressPath);
    }
    
    //画出外边的圆环
    CGContextSetStrokeColorWithColor(ctx, self.bigCircleColor.CGColor);
    CGMutablePathRef bigCirclePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(bigCirclePath, NULL, CGRectMake(2, 2, self.bounds.size.width-4, self.bounds.size.height-4));
    CGContextAddPath(ctx, bigCirclePath);
    CGContextSetLineWidth(ctx, self.bigCircleWidth);
    CGContextStrokePath(ctx);
    CGPathRelease(bigCirclePath);
//    NSInteger fff = ceil(2.5); //取整的方法
//    NSLog(@"%ld",(long)fff);
}

@end


@implementation ProductProgressView

+ (void)initialize
{
    if (self == [ProductProgressView class]) {
        ProductProgressView *productProgressViewAppearance = [ProductProgressView appearance];
        [productProgressViewAppearance setTrackTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
        [productProgressViewAppearance setProgressTintColor:[UIColor whiteColor]];
        [productProgressViewAppearance setBigCircleColor:[UIColor whiteColor]];
        [productProgressViewAppearance setBigVircleWidth:1];
        [productProgressViewAppearance setBackgroundColor:[UIColor clearColor]];
        [productProgressViewAppearance setClockwiseProgress:YES];
    }
}

+(Class)layerClass {
    return [ProductProgressLayer class];
}
- (ProductProgressLayer *)productProgressLayer {
    return (ProductProgressLayer *)self.layer;
}
- (id)init {
    return [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
}
- (void)didMoveToWindow {
    CGFloat windowContentsScale = self.window.screen.scale;
    self.productProgressLayer.contentsScale = windowContentsScale;
    [self.productProgressLayer setNeedsDisplay];
}
#pragma mark - Progress

- (CGFloat)progress
{
    return self.productProgressLayer.progress;
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO initialDelay:0 withDuration:0];
}


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay withDuration:(CFTimeInterval)duration {
    [self.productProgressLayer removeAnimationForKey:@"progress"];
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = duration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        animation.beginTime = CACurrentMediaTime() + initialDelay;
        animation.delegate = self;
        [self.productProgressLayer addAnimation:animation forKey:@"progress"];
    } else {
        [self.productProgressLayer setNeedsDisplay];
        self.productProgressLayer.progress = pinnedProgress;
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    NSNumber *pinnedProgressNumber = [animation valueForKey:@"toValue"];
    self.productProgressLayer.progress = [pinnedProgressNumber floatValue];
}


#pragma mark - UIAppearance methods

- (UIColor *)trackTintColor {
    return self.productProgressLayer.trackTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    self.productProgressLayer.trackTintColor = trackTintColor;
    [self.productProgressLayer setNeedsDisplay];
}

- (UIColor *)progressTintColor {
    return self.productProgressLayer.progressTintColor;
}
- (void)setProgressTintColor:(UIColor *)progressTintColor {
    self.productProgressLayer.progressTintColor = progressTintColor;
    [self.productProgressLayer setNeedsDisplay];
}

- (UIColor *)bigCircleColor {
    return self.productProgressLayer.bigCircleColor;
}
- (void)setBigCircleColor:(UIColor *)bigCircleColor {
    self.productProgressLayer.bigCircleColor = bigCircleColor;
    [self.productProgressLayer setNeedsDisplay];
}

-(void)setBigVircleWidth:(CGFloat)bigVircleWidth {
    self.productProgressLayer.bigCircleWidth = bigVircleWidth;
    [self.productProgressLayer setNeedsDisplay];
}
-(CGFloat)bigVircleWidth {
    return self.productProgressLayer.bigCircleWidth;
}

- (NSInteger)clockwiseProgress {
    return self.productProgressLayer.clockwiseProgress;
}
- (void)setClockwiseProgress:(NSInteger)clockwiseProgres {
    self.productProgressLayer.clockwiseProgress = clockwiseProgres;
    [self.productProgressLayer setNeedsDisplay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
