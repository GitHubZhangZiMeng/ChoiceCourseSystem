//
//  LoginViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/2.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "LoginViewController.h"
#import "ChoiceCourseViewController.h"
#import "CancelCourseViewController.h"
#import "PersonViewController.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *progressHUD;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameTF.text = [[UserManager new] GetUsername];
    
    NSLog(@"%@",NSHomeDirectory());
    
    
    // Do any additional setup after loading the view from its nib.
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
    
    if (self.usernameTF.text.length != 0 && self.pwdTF.text.length != 0)
    {
        [[UserManager new] SaveUserInfo:self.usernameTF.text andPWD:self.pwdTF.text];
        ChoiceCourseViewController *choiseVC = [[ChoiceCourseViewController alloc] init];
        choiseVC.view.backgroundColor = [UIColor whiteColor];
        choiseVC.tabBarItem.title=@"选课";
        choiseVC.tabBarItem.image=[UIImage imageNamed:@"book"];
        UINavigationController *choiseNav = [[UINavigationController alloc] initWithRootViewController:choiseVC];
        //背景颜色
        [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
        //title 颜色
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        
        CancelCourseViewController *cancelVC = [[CancelCourseViewController alloc] init];
        cancelVC.tabBarItem.title=@"退选";
        cancelVC.tabBarItem.image=[UIImage imageNamed:@"cancle"];
        UINavigationController *cancelNav = [[UINavigationController alloc] initWithRootViewController:cancelVC];
        
        
        PersonViewController *personVC = [[PersonViewController alloc] init];
        personVC.tabBarItem.title=@"个人";
        personVC.tabBarItem.image=[UIImage imageNamed:@"person"];
        UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:personVC];
        
        UITabBarController *tabbarController = [[UITabBarController alloc] init];
        tabbarController.viewControllers = @[choiseNav,cancelNav,personNav];
        tabbarController.tabBar.tintColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
        
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.window.rootViewController=tabbarController;
    }
    else
    {
        [AlertNotice showAlert:2 withTitle:nil withContent:nil withVC:self clickLeftBtn:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } clickRightBtn:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    
    
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:progressHUD];
//    progressHUD.delegate = self;
//    progressHUD.labelText = @"登录中...";
//    [progressHUD showWhileExecuting:@selector(loginPro) onTarget:self withObject:nil animated:YES];
    

//    
}

- (void)loginPro
{
    
    //网络请求登陆
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
