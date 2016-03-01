//
//  NewHomeCell.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "NewHomeCell.h"
#import "DRLineProgressView.h"

@interface NewHomeCell ()<DRLineProgressViewDelegate>

/** 当前进度指示(当前版本不需要设置进度) */
@property (weak, nonatomic) IBOutlet DRLineProgressView *progressView;
/** 利率 */
@property (weak, nonatomic) IBOutlet UILabel *yieldLabel;
/** 起投金额 */
@property (weak, nonatomic) IBOutlet UILabel *beginAmountLabel;
/** 投资期限 */
@property (weak, nonatomic) IBOutlet UILabel *investPeriodLabel;
/** 剩余分数 */
@property (weak, nonatomic) IBOutlet UILabel *restNumLabel;
//动态计算的宽高
/** buyButton的宽 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width_buyButton;
/** buyButton距离底部的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_buyButton;

@end

@implementation NewHomeCell

- (void)awakeFromNib {
    // Initialization code
    CGFloat progressViewHeight = [UIScreen mainScreen].bounds.size.width * 3 /4 - 50;
    _progressView.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:(0.0 / 255.0) green:(151.0 / 255.0) blue:(224.0 / 255.0) alpha:1.0];//[UIColor clearColor];
    _progressView.mDelegate = self;
    _progressView.radius = progressViewHeight/2-3;
    _progressView.innerRadius = progressViewHeight/2-3-12;
    _progressView.color = [UIColor clearColor];//RGB(0.0, 124.0, 188.0);
    _progressView.total = 72;
    _progressView.startAngle = M_PI * 0.72;
    _progressView.endAngle = M_PI * 2.32;
    _progressView.animationDuration = 0.75;
    _progressView.layer.shouldRasterize = YES;
    
    //动态改变 宽高
    self.width_buyButton.constant = self.width_buyButton.constant*[UIScreen mainScreen].bounds.size.width/320.0;
    self.bottom_buyButton.constant = self.bottom_buyButton.constant*[UIScreen mainScreen].bounds.size.width*3/4.0/240;
}
- (void)updateData:(NSObject *)model {
    /* 刷新进度 */
    [_progressView setCompleted:1.0*_progressView.total animated:YES];
    
}

- (IBAction)buyButtonClick:(UIButton *)sender {
    if ([self.mDelegate respondsToSelector:@selector(newHomeCell:clickAtBuyButton:)]) {
        [self.mDelegate newHomeCell:self clickAtBuyButton:sender];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
