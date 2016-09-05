
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
    [self setupRightnavigationItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupRightnavigationItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"截屏" forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;

}

/**
 *  截WebView的全部屏
 */
- (UIImage *)screenShot:(UIScrollView *)scrollView {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, [UIScreen mainScreen].scale);

    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect saveFrame = scrollView.frame;

    //将collectionView的偏移量设置为(0,0)
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width,scrollView.contentSize.height);

    //在当前上下文中渲染出collectionView
    [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();

    //恢复collectionView的偏移量
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = saveFrame;

    UIGraphicsEndImageContext();

    if (image != nil) {
        return image;
    }

    return nil;
}
/**
 *  点击按钮截屏
 */
- (void)buttonClick:(id)sender {

    UIImage *screenImage = [self screenShot:self.tableView];
    [self tapSaveImageToIphone:screenImage];
}

/**
 *  保存到系统相册
 */
- (void)tapSaveImageToIphone:(UIImage *)image{

    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        NSLog(@"%@",error);
        NSLog(@"保存失败");
    } else  {
        NSLog(@"截图成功,请求相册查看");
    }
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
    NSString *orderNum = [NSString stringWithFormat:@"%ld",1001+indexPath.row];
    NSDictionary *dict = @{@"status":@(statusValue),@"orderNum":orderNum};
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
