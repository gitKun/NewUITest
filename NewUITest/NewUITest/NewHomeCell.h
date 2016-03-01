//
//  NewHomeCell.h
//  银洲街新UI测试
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewHomeCell;

@protocol NewHomeCellDelegate <NSObject>

- (void)newHomeCell:(NewHomeCell *)cell clickAtBuyButton:(UIButton *)buyButton;

@end

@interface NewHomeCell : UITableViewCell

@property (nonatomic, weak) id<NewHomeCellDelegate>mDelegate;

- (void)updateData:(NSObject *)model;

@end
