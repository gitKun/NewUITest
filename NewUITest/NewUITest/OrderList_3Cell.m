//
//  OrderList_3Cell.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "OrderList_3Cell.h"
#import "ProductProgressView.h"

@interface OrderList_3Cell ()

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
/** 订单状态详情说明 */
@property (weak, nonatomic) IBOutlet UILabel *statusInfoLabel;

@end

@implementation OrderList_3Cell

- (void)awakeFromNib {
    self.statusView.trackTintColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.statusView.progressTintColor = [UIColor clearColor];
    self.statusView.progress = 1.0;
    self.statusView.bigCircleColor = [UIColor whiteColor];
    self.statusView.bigVircleWidth = 1.5;
    self.statusLabel.text = @"下单失败";
}
- (void)showDataWithModel:(id)model {
    switch ([[model objectForKey:@"status"] integerValue]) {
        case 10:
        {
            self.statusView.trackTintColor = [UIColor colorWithRed:253/255.0 green:0 blue:0 alpha:1];
            self.statusLabel.text = @"已起息";
        }
            break;
        case 20:
        {
            self.statusView.trackTintColor = [UIColor colorWithRed:78/255.0 green:168/255.0 blue:221/255.0 alpha:1];
            self.statusLabel.text = @"付款中";
        }
            break;
        case 30:
        {
            self.statusView.trackTintColor = [UIColor colorWithRed:113/255.0 green:168/255.0 blue:89/255.0 alpha:1];
            self.statusLabel.text = @"已结息";
        }
            break;
        case 40:
        {
            self.statusView.trackTintColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
            if (arc4random()%2) {
                self.statusLabel.text = @"已结束";
            }else {
                self.statusLabel.text = @"下单失败";
            }
        }
            break;
        default:
            break;
    }
    
}
//- (void)colorsForStatusView {
//    UIColor *huise = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
//    UIColor *hongse = [UIColor colorWithRed:253/255.0 green:0 blue:0 alpha:1];
//    UIColor *lanse = [UIColor colorWithRed:78/255.0 green:168/255.0 blue:221/255.0 alpha:1];
//    UIColor *lvse = [UIColor colorWithRed:113/255.0 green:168/255.0 blue:89/255.0 alpha:1];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
