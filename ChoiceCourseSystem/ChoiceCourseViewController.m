//
//  choiceCourseViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "ChoiceCourseViewController.h"

#import "CollegeTableViewCell.h"
#import "YearClassVC.h"
#import "CourseVC.h"
#import "SelectedViewController.h"
@interface ChoiceCourseViewController ()

@property (nonatomic, strong)NSArray *collegeArr;


@end

@implementation ChoiceCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选课";
    //请求学院数据
    
    
    self.collegeArr = [NSArray arrayWithObjects:@"大气科学学院",@"资源环境学院",@"电子工程学院",@"通信工程学院",@"控制工程学院",@"计算机学院",@"软件工程学院",@"信息安全工程学院",@"应用数学学院",@"管理学院",@"外国语学院",@"光电技术学院",@"文化艺术学院",nil];
    
//   [[NetHelper new] getRequest:nil withNetBlock:^(id responseObject) {
//       NSLog(@"******%@",responseObject);
//   } withErrBlock:^(id err) {
//       NSLog(@"______%@",err);
//   }];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedViewController *vc = [[SelectedViewController alloc] init];
    vc.collegeName = self.collegeArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.collegeArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CollegeTableViewCell" owner:nil options:nil][0];
    }
    cell.collegeCellLab.text = self.collegeArr[indexPath.row];
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
