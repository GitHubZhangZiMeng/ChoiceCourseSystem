//
//  SetPassWordViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/4/9.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SetPassWordViewController.h"

@interface SetPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassWord;
@property (weak, nonatomic) IBOutlet UITextField *NewPassWord;

@property (weak, nonatomic) IBOutlet UITextField *fixNewPW;

@end

@implementation SetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)EnterBtn:(id)sender {
    
    
    
    if (self.oldPassWord.text.length != 0 &&self.NewPassWord.text.length != 0 && self.fixNewPW.text.length != 0)
    {
//        @"{\"username\":\"%@\",\"password\":\"%@\"}"
        if([self.NewPassWord.text isEqualToString:self.fixNewPW.text])//验证密码正确
        {
            NSLog(@"%@",_username);
            [AlertNotice showAlert:3 withTitle:@"提示" withContent:@"是否确定修改密码" withVC:self clickLeftBtn:^{//修改密码
                
                [NetHelper postRequest:kURL_LoginUser withActionStr:@"changepwd" withDataStr:[NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\",\"newpassword\":\"%@\"}",self.username, self.oldPassWord.text,self.fixNewPW.text] withNetBlock:^(id responseObject) {
                    
                    NSLog(@"%@",responseObject);
                    if ([[responseObject objectForKey:@"errMsg"] rangeOfString:@"error"].location != NSNotFound)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [AlertNotice showAlertNotType:@"提示" withContent:@"旧密码不正确" withVC:self clickLeftBtn:^{
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }];
                        });
                        
                        
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [AlertNotice showAlertNotType:@"提示" withContent:@"密码修改成功" withVC:self clickLeftBtn:^{
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }];
                        });
                    }
                    
                } withErrBlock:^(id err) {
                    NSLog(@"%@",err);
                    
                }];
                
                
            } clickRightBtn:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        else
        {
            [AlertNotice showAlertNotType:@"提示" withContent:@"密码不一致" withVC:self clickLeftBtn:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        
        
//        if (oldPassword)//旧密码正确
//        {
//            if([self.NewPassWord.text isEqualToString:self.fixNewPW.text])//验证密码正确
//            {
//                [AlertNotice showAlert:3 withTitle:@"提示" withContent:@"是否确定修改密码" withVC:self clickLeftBtn:^{//修改密码
//                    
//                } clickRightBtn:^{
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }];
//            }
//            else
//            {
//                [AlertNotice showAlertNotType:@"提示" withContent:@"密码不一致" withVC:self clickLeftBtn:^{
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }];
//            }
//            
//        }
//        else
//        {
//            [AlertNotice showAlertNotType:@"提示" withContent:@"旧密码不正确" withVC:self clickLeftBtn:^{
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }];
//            
//            
//        }
        
    }
    else
    {
        [AlertNotice showAlertNotType:@"提示" withContent:@"输入框不能为空" withVC:self clickLeftBtn:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
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
