//
//  CourseViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "CourseViewController.h"
#import "PersonTableViewCell.h"
#import "SelectedViewController.h"
#import "SelectingHeadView.h"
@interface CourseViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *courselistArr;
@property (nonatomic, strong)NSArray *courseInfoArr;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=self.courseName;
    _commitBtn.hidden = YES;
    _courselistArr = [NSArray arrayWithObjects:@"选课时间",@"开课时间",@"开设学院",@"课程时长",@"授课教室",@"选择班级",nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        SelectingHeadView *view = [[NSBundle mainBundle] loadNibNamed:@"SelectingHeadView" owner:nil options:nil][0];
        view.courseNameLab.text = self.courseName;
        return view;
    }
    else
    {
        UILabel *lab = [[UILabel alloc] init];
        lab.text = _courselistArr[section];
        return lab;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _courselistArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 200;
    }
    else
    {
        return 30;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"qweqweadasdwadasdwdasdwa";
    
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
