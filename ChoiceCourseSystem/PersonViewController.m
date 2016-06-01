//
//  PersonViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonTableViewCell.h"
#import "SelectedViewController.h"
#import "CourseNameViewController.h"
#import "PersonHeaderView.h"
#import "SetPassWordViewController.h"
#import "LoginViewController.h"
#import "MyCourseVC.h"

@interface PersonViewController ()

@property (nonatomic,strong)NSArray *imgRowArr;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人设置";
    self.personArr = [NSMutableArray arrayWithObjects:@"我的选课",@"设置密码",@"退出登陆",@"关于我们",nil];
    self.imgRowArr = [NSArray arrayWithObjects:@"star",@"setPwd",@"tui",@"about_we", nil];
    NSLog(@"userid___%@",self.userid);
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark - table的代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PersonHeaderView *personHeader = [[NSBundle mainBundle] loadNibNamed:@"PersonHeaderView" owner:nil options:nil][0];
    
    personHeader.labOne.text = [NSString stringWithFormat:@"姓名：%@",self.name];
    personHeader.labTwo.text = [NSString stringWithFormat:@"教师工号：%@",self.numble];
    personHeader.labThree.text = [NSString stringWithFormat:@"所属学院：%@",self.college];
    
    return personHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0://我的选课
        {
            MyCourseVC *vc = [[MyCourseVC alloc] init];
            vc.userid = self.userid;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SetPassWordViewController *vc = [[SetPassWordViewController alloc] init];
            vc.username = self.numble;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:
            //  退出登录
            {
                [AlertNotice showAlert:1 withTitle:nil withContent:nil withVC:self clickLeftBtn:^{
                    [[UserManager new] ClearUserInfo];
                    AppDelegate *app = [UIApplication sharedApplication].delegate;
                    app.window.rootViewController=[LoginViewController new];
                } clickRightBtn:^{
                    
                }];
                
            }
            break;
            
        case 3:
        {
            [AlertNotice showAlertNotType:@"关于我们" withContent:@"成都信息工程大学教师选课系统\nFor iOS V1.0.0\nCopyright © 2016 zimeng.zhang" withVC:self clickLeftBtn:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
            break;
        
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.personArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    
    cell.personRowLab.text = self.personArr[indexPath.row];
    cell.personRowImg.image = [UIImage imageNamed:self.imgRowArr[indexPath.row]];
    return cell;
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
