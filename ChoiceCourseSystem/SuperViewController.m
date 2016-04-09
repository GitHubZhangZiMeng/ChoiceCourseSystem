//
//  SuperViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/8.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotNet) name:@"netWorkState" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)NotNet
{
    [AlertNotice showAlertNotType:@"提示" withContent:@"网络连接失败，请设置网络" withVC:self clickLeftBtn:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
