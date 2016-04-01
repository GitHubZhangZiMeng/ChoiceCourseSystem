//
//  LoginViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/2.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "LoginViewController.h"
//#import "YKNetHelper.h"
#import "ChoiceCourseViewController.h"
#import "CancelCourseViewController.h"
#import "PersonViewController.h"
#import "AppDelegate.h"

#import "MBProgressHUD.h"
@interface LoginViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *progressHUD;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notNet) name:@"netWorkState" object:nil];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)notNet
{
   [AlertNotice showAlert:0 withTitle:@"提示" withContent:@"网络请求失败，请检查你的网络设置" withVC:self clickLeftBtn:^{
       [self dismissViewControllerAnimated:YES completion:nil];
   } clickRightBtn:^{
       [self dismissViewControllerAnimated:YES completion:nil];
   }];
    
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

- (IBAction)loginBtn:(id)sender {
    
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progressHUD];
    progressHUD.delegate = self;
    progressHUD.labelText = @"登录中...";
    [progressHUD showWhileExecuting:@selector(loginPro) onTarget:self withObject:nil animated:YES];
    
    
    ChoiceCourseViewController *choiseVC = [[ChoiceCourseViewController alloc] init];
    choiseVC.view.backgroundColor = [UIColor whiteColor];
    choiseVC.tabBarItem.title=@"选课";
    choiseVC.tabBarItem.image=[UIImage imageNamed:@"ChoiseCourse"];
    UINavigationController *choiseNav = [[UINavigationController alloc] initWithRootViewController:choiseVC];
    
    CancelCourseViewController *cancelVC = [[CancelCourseViewController alloc] init];
    cancelVC.tabBarItem.title=@"退选";
    cancelVC.tabBarItem.image=[UIImage imageNamed:@"CancelChiose"];
    UINavigationController *cancelNav = [[UINavigationController alloc] initWithRootViewController:cancelVC];
    
    
    PersonViewController *personVC = [[PersonViewController alloc] init];
    personVC.tabBarItem.title=@"个人";
    personVC.tabBarItem.image=[UIImage imageNamed:@"person"];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:personVC];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[choiseNav,cancelNav,personNav];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController=tabbarController;
    
    

//    
}
- (void)loginPro
{
    sleep(5);
    //网络请求登陆
}
@end
