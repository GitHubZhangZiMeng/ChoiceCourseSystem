//
//  ClassViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "ClassViewController.h"
#import "PersonTableViewCell.h"
#import "CourseViewController.h"
#import "SelectedViewController.h"
@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *classArr;
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择班级";
    self.classArr = [NSArray arrayWithObjects:@"2012届1班",@"2012届2班",@"2012届3班",@"2012届4班",@"2012届5班", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedViewController*vc = [[SelectedViewController alloc] init];
    vc.collegeName = self.collegeName;
    vc.yearClass = self.yearClass;
    vc.major = self.major;
    vc.clas = self.classArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
        
    }
    cell.personRowLab.text = self.classArr[indexPath.row];
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
