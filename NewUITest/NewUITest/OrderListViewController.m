
//
//  OrderListViewController.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderList_3Cell.h"

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark ===== UITabelViewDelegate && UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderList_3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderList_3CellID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderList_3Cell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger statusValue = (indexPath.row % 4 + 1) * 10;
    NSDictionary *dict = @{@"status":@(statusValue)};
    OrderList_3Cell *oCell = (OrderList_3Cell *)cell;
    [oCell showDataWithModel:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
