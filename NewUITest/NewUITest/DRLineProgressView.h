//
//  DRLineProgressView.h
//  DRLineProgress
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRLineProgressView;

@protocol DRLineProgressViewDelegate <NSObject>
@optional
- (void)LineProgressViewAnimationDidStart:(DRLineProgressView *)lineProgressView;
- (void)LineProgressViewAnimationDidStop:(DRLineProgressView *)lineProgressView;
@end


@interface DRLineProgressView : UIView

/** 线条的总个数 */
@property (nonatomic,assign) int total;
/** 还没有完成的线条的颜色 */
@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) int completed;
/** 已完成的进度线颜色 (默认为白色) */
@property (nonatomic,strong) UIColor *completedColor;
/** 外部半径 和 innerRadius 决定进度线的长短 */
@property (nonatomic,assign) CGFloat radius;
/** 内部半径 和 radius 决定进度线的长度 */
@property (nonatomic,assign) CGFloat innerRadius;
/** 指示器开始的位置 */
@property (nonatomic,assign) CGFloat startAngle;
/** 指示器结束的位置 */
@property (nonatomic,assign) CGFloat endAngle;
/** 动画进的的时间 */
@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic) id<DRLineProgressViewDelegate> mDelegate;

- (void)setCompleted:(int)completed animated:(BOOL)animated;

@end
