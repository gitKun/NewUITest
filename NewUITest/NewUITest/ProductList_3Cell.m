//
//  ProductList_3Cell.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ProductList_3Cell.h"
#import "ProductProgressView.h"
#import "DRSplitLineView.h"

@interface ProductList_3Cell ()

/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
/** 期限 */
@property (weak, nonatomic) IBOutlet UILabel *productDeadlineLabel;
/** 安全保证 */
@property (weak, nonatomic) IBOutlet UIImageView *safetyMarkImg;
/** 年化收益 */
@property (weak, nonatomic) IBOutlet UILabel *yieldLabel;
/** 剩余份数 */
@property (weak, nonatomic) IBOutlet UILabel *restNumLabel;
/** 起购金额 */
@property (weak, nonatomic) IBOutlet UILabel *beginAmountLabel;
/** 进度指示 */
@property (weak, nonatomic) IBOutlet ProductProgressView *precentProgressView;
/** 分割线 */
@property (weak, nonatomic) IBOutlet DRSplitLineView *splitLineView;

//动态计算行间距
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *space_labelsArr;


@end

@implementation ProductList_3Cell

- (void)awakeFromNib {
    
    self.splitLineView.lineColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    self.splitLineView.splitWidth = 6.0;
    
    //动态计算出间距
    for (NSLayoutConstraint *constraint in self.space_labelsArr) {
        CGFloat spaceValue = ([UIScreen mainScreen].bounds.size.width-15-15-20-42)*constraint.constant/(320-15-15-20-42);
        NSInteger spaceIntValue = ceil(spaceValue);
        constraint.constant = spaceIntValue;
    }
}


- (void)showProgress:(CGFloat)currentProgress {
    if (currentProgress == 1.0) {
        self.precentProgressView.trackTintColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        self.precentProgressView.progressTintColor = [UIColor clearColor];
        self.precentProgressView.clockwiseProgress = YES;
        self.precentProgressView.bigCircleColor = [UIColor whiteColor];
        self.precentProgressView.bigVircleWidth = 1.5;
    }else {
        self.precentProgressView.trackTintColor = [UIColor clearColor];
        self.precentProgressView.progressTintColor = [UIColor colorWithRed:219/255.0 green:29/255.0 blue:10/255.0 alpha:1];
        self.precentProgressView.clockwiseProgress = YES;
        self.precentProgressView.bigCircleColor = [UIColor colorWithRed:219/255.0 green:29/255.0 blue:10/255.0 alpha:1];
        self.precentProgressView.bigVircleWidth = 1.0;
    }
    self.precentProgressView.progress = currentProgress;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
