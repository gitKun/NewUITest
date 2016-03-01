//
//  LoginViewController.m
//  银洲街新UI测试
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "LoginViewController.h"
#import "NewLoginView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NewLoginView *newView = [[[NSBundle mainBundle] loadNibNamed:@"NewLoginView" owner:self options:nil] lastObject];
    newView.frame = CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height-64);
    [self.view addSubview:newView];
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
