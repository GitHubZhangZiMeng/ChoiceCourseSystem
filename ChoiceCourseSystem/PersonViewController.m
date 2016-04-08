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
@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人设置";
    self.personArr = [NSMutableArray arrayWithObjects:@"我的选课",@"设置密码",@"退出登陆",@"关于我们",nil];
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
    UIView *vi = [[UIView alloc] init];
    
//    UILabel *nameLab = [[UILabel alloc] init];
//    nameLab.text = @"姓名：XXX";
//    nameLab.textAlignment = NSTextAlignmentCenter;
//    nameLab.font = [UIFont systemFontOfSize:20];
//    nameLab.numberOfLines = 0;
//    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = @"用户名：XXX";
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.font = [UIFont systemFontOfSize:20];
//    lab.numberOfLines = 0;
//    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = @"用户名：XXX";
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.font = [UIFont systemFontOfSize:20];
//    lab.numberOfLines = 0;
//    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = @"用户名：XXX";
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.font = [UIFont systemFontOfSize:20];
//    lab.numberOfLines = 0;
    return vi;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarController.tabBar.hidden = YES;
    switch (indexPath.row)
    {
        case 0://我的选课
            [self.navigationController pushViewController:[SelectedViewController new] animated:YES];
            break;
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        case 3:
            
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
    return 100;
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
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    cell.personRowLab.text = self.personArr[indexPath.row];
    
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
