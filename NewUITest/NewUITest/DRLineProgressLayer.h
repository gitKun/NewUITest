//
//  DRLineProgressLayer.h
//  DRLineProgress
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DRLineProgressLayer : CALayer

@property (nonatomic,assign) int total;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) int completed;
@property (nonatomic,strong) UIColor *completedColor;

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat innerRadius;

@property CGFloat startAngle;
@property CGFloat endAngle;

@property (nonatomic, assign) CFTimeInterval animationDuration;

@end
