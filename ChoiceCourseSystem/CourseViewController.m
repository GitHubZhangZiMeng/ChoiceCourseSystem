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
@interface CourseViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *courseArr;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择课程";
    self.courseArr = [NSArray arrayWithObjects:@"大学英语",@"高等数学",@"工程导论",@"计算机科学基础",@"人生规划教育",@"思想道德修养和法律基础",@"体育1",@"网页制作",@"线性代数A", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedViewController *vc = [[SelectedViewController alloc] init];
    vc.collegeName = self.collegeName;
    vc.yearClass = self.yearClass;
    vc.major = self.major;
    vc.clas = self.clas;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    cell.personRowLab.text = self.courseArr[indexPath.row];
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
