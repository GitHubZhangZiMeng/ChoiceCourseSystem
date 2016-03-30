//
//  LoginViewController.h
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/2.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

- (IBAction)loginBtn:(id)sender;

@end
