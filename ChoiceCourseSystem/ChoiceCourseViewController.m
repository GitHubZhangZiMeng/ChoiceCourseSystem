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
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NetHelper postRequest:kURL_college withActionStr:@"list" withDataStr:[NSString stringWithFormat:@"{\"collegename\":\"\"}"] withNetBlock:^(id responseObject) {
            //查询所有学院
            NSLog(@"%@",responseObject);
            NSLog(@"%@",[responseObject objectForKey:@"colleges"]);
            self.collegeArr = [responseObject objectForKey:@"colleges"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_collegeTable reloadData];
            });
            
        } withErrBlock:^(id err) {
            
        }];
    });
    

    
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
    vc.collegeName = [self.collegeArr[indexPath.row] objectForKey:@"name"];
    vc.collegeID = [self.collegeArr[indexPath.row]objectForKey:@"collegeid"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",[self.collegeArr count]);
    return [self.collegeArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CollegeTableViewCell" owner:nil options:nil][0];
    }
    cell.collegeCellLab.text = [self.collegeArr[indexPath.row] objectForKey:@"name"];
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
