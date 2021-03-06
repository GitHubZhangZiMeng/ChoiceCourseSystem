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
#import "NewViewController.h"
@interface LoginViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *hub;
    NSString *userName;
    NSString *passWord;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userName = [[UserManager new] GetUsername];
    passWord = [[UserManager new] GetPassWord];
    
    hub = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    hub.delegate = self;
    hub.labelText = @"登陆中...";
    
    
    if (userName&&passWord)
    {
        self.usernameTF.text = userName;
        self.pwdTF.text = passWord;
        [hub showWhileExecuting:@selector(loginPro) onTarget:self withObject:nil animated:YES];
    }
    
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
        [hub showWhileExecuting:@selector(loginPro) onTarget:self withObject:nil animated:YES];
    }
    else
    {
        [AlertNotice showAlertNotType:@"提示" withContent:@"输入框不能为空" withVC:self clickLeftBtn:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)loginPro
{
    [NetHelper postRequest:kURL_LoginUser withActionStr:@"login" withDataStr:[NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.usernameTF.text,self.pwdTF.text]
        withNetBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
            if ([responseObject isKindOfClass:[NSString class]])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [AlertNotice showAlertNotType:@"提示" withContent:@"网络状态差，请求超时" withVC:self clickLeftBtn:^{
                        
                    }];
                });
                return ;
            }
            if ([[responseObject objectForKey:@"errMsg"] rangeOfString:@"error"].location!=NSNotFound)
            {
                NSLog(@"no");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [AlertNotice showAlertNotType:@"提示" withContent:@"账号密码错误" withVC:self clickLeftBtn:^{
                        
                    }];
                });
                
            }
            else
            {
                NSLog(@"yes");
                NSLog(@"%@",[responseObject objectForKey:@"user"]);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[UserManager new] SaveUserInfo:self.usernameTF.text andPWD:self.pwdTF.text andUserid:[[responseObject objectForKey:@"user"] objectForKey:@"userid"]];
                    ChoiceCourseViewController *choiseVC = [[ChoiceCourseViewController alloc] init];
                    choiseVC.view.backgroundColor = [UIColor whiteColor];
                    choiseVC.tabBarItem.title=@"选课";
                    choiseVC.tabBarItem.image=[UIImage imageNamed:@"book"];
                    UINavigationController *choiseNav = [[UINavigationController alloc] initWithRootViewController:choiseVC];
                    //背景颜色
                    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
                    //title 颜色
                    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                    
                    NewViewController *newVC = [[NewViewController alloc] init];
                    newVC.view.backgroundColor = [UIColor whiteColor];
                    newVC.tabBarItem.title = @"消息";
                    newVC.tabBarItem.image = [UIImage imageNamed:@"new"];
                    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:newVC];

                    
                    CancelCourseViewController *cancelVC = [[CancelCourseViewController alloc] init];
                    cancelVC.userid = [[responseObject objectForKey:@"user"] objectForKey:@"userid"];
                    cancelVC.tabBarItem.title=@"退选";
                    cancelVC.tabBarItem.image=[UIImage imageNamed:@"cancle"];
                    UINavigationController *cancelNav = [[UINavigationController alloc] initWithRootViewController:cancelVC];
                    
                    PersonViewController *personVC = [[PersonViewController alloc] init];
                    personVC.userid = [[responseObject objectForKey:@"user"] objectForKey:@"userid"];
                    personVC.name = [[responseObject objectForKey:@"user"]objectForKey:@"realname"];
                    personVC.numble = [[responseObject objectForKey:@"user"] objectForKey:@"username"];
                    personVC.college = [[responseObject objectForKey:@"college"] objectForKey:@"name"];
                    
                    personVC.tabBarItem.title=@"个人";
                    personVC.tabBarItem.image=[UIImage imageNamed:@"person"];
                    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:personVC];
                    
                    UITabBarController *tabbarController = [[UITabBarController alloc] init];
                    tabbarController.viewControllers = @[choiseNav,newNav,cancelNav,personNav];
                    tabbarController.tabBar.tintColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
                    
                    
                    AppDelegate *app = [UIApplication sharedApplication].delegate;
                    app.window.rootViewController=tabbarController;
                });
                
                

            }
            
    } withErrBlock:^(id err) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
