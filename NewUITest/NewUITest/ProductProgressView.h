//
//  ProductProgressView.h
//  银洲街新UI测试
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductProgressView : UIView

/** 设置绘制的进度的环形(实心圆形)的颜色 */
@property(nonatomic, strong) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;
/** 设置绘制进度条使用的颜色*/
@property(nonatomic, strong) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;
/** 外部圆环的颜色 */
@property (nonatomic, strong) UIColor *bigCircleColor UI_APPEARANCE_SELECTOR;
/** 外部圆环的粗细 */
@property (nonatomic) CGFloat bigVircleWidth UI_APPEARANCE_SELECTOR;
/** 设置是否按顺时针进行绘制进度条 */
@property(nonatomic) NSInteger clockwiseProgress UI_APPEARANCE_SELECTOR; // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(
/** 设置当前的 进度 不带动画效果*/
@property(nonatomic) CGFloat progress;

/**
 *  @brief  设置带动画效果的进度指示
 *
 *  @param progress     当前产品的进度
 *  @param animated     是否带动画
 *  @param initialDelay 等待动画开始时间(延迟开始动画的时间)
 *  @param duration     动画持续时间
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay withDuration:(CFTimeInterval)duration;

@end
