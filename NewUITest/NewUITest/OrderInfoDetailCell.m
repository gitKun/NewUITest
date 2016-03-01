//
//  OrderInfoDetailCell.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "OrderInfoDetailCell.h"
#import "ProductProgressView.h"

@interface OrderInfoDetailCell ()

/** 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
/** 订单金额 */
@property (weak, nonatomic) IBOutlet UILabel *orderAmountLabel;
/** 预期收益 */
@property (weak, nonatomic) IBOutlet UILabel *expectEarningLabel;
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
/** 标示订单状态的背景 */
@property (weak, nonatomic) IBOutlet ProductProgressView *statusView;
/** 标记订单的状态 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;





@end


@implementation OrderInfoDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
