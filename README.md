# NewUITest
动画，进度指示，绘图

####自己写的2个进度指示

1、DRLineProgressView 和 DRLineProgressLayer 用到了绘图的知识

头文件如下，有兴趣的可以改用 _CAShaperLayer_ 改写 

```
@interface DRLineProgressLayer : CALayer
/** 总共的线条数 */
@property (nonatomic,assign) int total;
@property (nonatomic,strong) UIColor *color;
/** 完成的个数 */
@property (nonatomic,assign) int completed;
@property (nonatomic,strong) UIColor *completedColor;
/** 外半径和内半径共同决定每个进度条的长度 */
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat innerRadius;
/** 开始和结束的角度 (关于绘图时 开始角度 0 的起始点 为右顶点) */
@property CGFloat startAngle;
@property CGFloat endAngle;

@property (nonatomic, assign) CFTimeInterval animationDuration;

@end

```

*核心代码*

```
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
        //设置线条起点和终点的状态 (例如：圆角)
        //CGContextSetLineCap(contextRef, kCGLineCapRound);
        CGContextDrawPath(contextRef, kCGPathFillStroke);
    }
    //在这里你可以 对最后绘制出来的那条已完成的线条所在位置进行自己定制 (例如：绘制一个圆环标示一下)
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
//    CAShapeLayer *shapeLayer ;
//    [shapeLayer setLineCap:kCALineCapRound];
}
```

*绘图起始0角度如图，后面请参考此图*

![角度计算.png](https://ooo.0o0.ooo/2016/03/01/56d53f8cb0a11.png)


DRLineProgressView 如下图所示

![DRProgressView.gif](https://ooo.0o0.ooo/2016/03/01/56d5408cbda39.gif)


2、ProducProgressView 

核心代码

```
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
```
效果图如下

![ProdProgressView.gif](https://ooo.0o0.ooo/2016/03/01/56d54170ed0e4.gif)

###自己写的分割线 从此告别UI切图拉伸

DRSplitLineView核心代码如下 用了 *UIBezierPath*和 _CAShapeLayer_ 结合来实现的

```
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
```

效果图如 *ProductProgreView* 效果图中的 分割线

###浅浅的说下动画

参考 DRLineProgressLayer 中的 方法

```
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"completed"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}
```
这样你就可以对自己定义的*属性*进行添加动画效果了 但是注意：如果覆盖了 CALayer 中已有的属性 例如 *progress* 属性，那么在 .m 文件中拟具有必要 添加 如下代码:

```
@dynamic progress;
``` 
具体原因请自查 *@dynamic的用法* 

###最不重要的

这个Demo用StoryBoard完成的 仅仅根据屏幕适配了 view 的大小 和各 view 的间距，并没有去根据 屏幕来变大或缩小字体
