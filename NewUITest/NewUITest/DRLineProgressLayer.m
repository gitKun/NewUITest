//
//  DRLineProgressLayer.m
//  DRLineProgress
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "DRLineProgressLayer.h"

@implementation DRLineProgressLayer

- (id)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        if ([layer isKindOfClass:[DRLineProgressLayer class]]) {
            DRLineProgressLayer *other = layer;
            self.total = other.total;
            self.color = other.color;
            self.completed = other.completed;
            self.completedColor = other.completedColor;
            self.radius = other.radius;
            self.innerRadius = other.innerRadius;
            self.startAngle = other.startAngle;
            self.endAngle = other.endAngle;
            self.shouldRasterize = YES;
        }
    }
    return self;
}

+ (id)layer {
    DRLineProgressLayer *result = [[DRLineProgressLayer alloc] init];
    return result;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"completed"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)contextRef {
    //    CGFloat originalRadius = _radius;
    CGFloat totalAngle = _endAngle - _startAngle;
    CGRect rect = self.bounds;
    CGPoint cP = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGContextSetLineJoin(contextRef, kCGLineJoinRound);
    CGContextSetFlatness(contextRef, 2.0);
    CGContextSetAllowsAntialiasing(contextRef, true);
    CGContextSetShouldAntialias(contextRef, true);
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationHigh);
    CGContextSetLineWidth(contextRef,2.0f);     //设置线条宽度
    
    for (int i = 0; i < _total; i++) {
        //计算初始点
        CGFloat x0 = cP.x + cosf(_startAngle + totalAngle*i/_total)*_innerRadius;
        CGFloat y0 = cP.y + sinf(_startAngle + totalAngle*i/_total)*_innerRadius;
        CGContextMoveToPoint(contextRef, x0, y0);
        //计算终点
        CGFloat x = cP.x + cosf(_startAngle + totalAngle*i/_total)*_radius;
        CGFloat y = cP.y + sinf(_startAngle + totalAngle*i/_total)*_radius;
        //画线
        CGContextAddLineToPoint(contextRef, x, y);
        //设置颜色
        CGContextSetStrokeColorWithColor(contextRef, _color.CGColor);
        CGContextSetFillColorWithColor(contextRef, _color.CGColor);
        CGContextDrawPath(contextRef, kCGPathFillStroke);
    }
    for (int i = 0; i < _completed; i++) {
        CGFloat x0 = cP.x + cosf(_startAngle + totalAngle*i/_total)*_innerRadius;
        CGFloat y0 = cP.y + sinf(_startAngle + totalAngle*i/_total)*_innerRadius;
        CGContextMoveToPoint(contextRef, x0, y0);
        CGFloat x = cP.x + cosf(_startAngle + totalAngle*i/_total)*_radius;
        CGFloat y = cP.y + sinf(_startAngle + totalAngle*i/_total)*_radius;
        CGContextAddLineToPoint(contextRef, x, y);
        CGContextSetStrokeColorWithColor(contextRef, _completedColor.CGColor);   //设置颜色
        CGContextSetFillColorWithColor(contextRef, _completedColor.CGColor);
        CGContextDrawPath(contextRef, kCGPathFillStroke);
    }
}


@end
