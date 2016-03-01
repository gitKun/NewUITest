//
//  DRSplitLineView.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "DRSplitLineView.h"

@implementation DRSplitLineView

+ (Class)layerClass {
    return [CAShapeLayer class];
}
- (CAShapeLayer *)shapeLayer {
    return (CAShapeLayer *)self.layer;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (void)setSplitWidth:(CGFloat)splitWidth {
    _splitWidth = splitWidth;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //计算总共的分割点
    CGFloat vWidth = CGRectGetWidth(rect);
    CGFloat yPoint = CGRectGetMidY(rect);
    CGFloat amount = vWidth/(self.splitWidth? :6.0);
    //向后取整数
    int behindPoint = (int)amount;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < behindPoint; i++) {
        [bezierPath moveToPoint:CGPointMake(i*_splitWidth, yPoint)];
        if (i == behindPoint) {//奇数个点画到末尾
            [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), yPoint)];
            break;
        }
        [bezierPath addLineToPoint:CGPointMake(++i*_splitWidth, yPoint)];
        if (i == behindPoint) {//偶数个点画到最后一个点
            break;
        }
    }
    self.shapeLayer.path = bezierPath.CGPath;
    self.shapeLayer.lineWidth = 1;
    self.shapeLayer.strokeColor = self.lineColor.CGColor;
}
@end
