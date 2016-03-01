//
//  ProductViewController.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductProgressView.h"
#import "ProductList_3Cell.h"

@interface ProductViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)testFunc1 {
    ProductProgressView *pud3 = [[ProductProgressView alloc] initWithFrame:CGRectMake(150, 100, 42, 42)];
    pud3.trackTintColor = [UIColor grayColor];
    pud3.progressTintColor = [UIColor yellowColor];
    /* 是否按照顺时针进行绘制 进度 */
    pud3.clockwiseProgress = YES;
    pud3.progress = 0.36;
    pud3.bigCircleColor = [UIColor whiteColor];
    [self.view addSubview:pud3];
}

#pragma mark ==== UITableViewDelegate && UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductList_3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProdectList_3CellID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductList_3Cell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //优化性能 在此方法中对 cell 进行填充操作
    ProductList_3Cell *pCell = (ProductList_3Cell *)cell;
    [pCell showProgress:(arc4random()%9+1)/10.0];
    if (indexPath.row == 0) {
        [pCell showProgress:1.0];
    }else {
        [pCell showProgress:(arc4random()%134+1)/135.0];
    }
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
