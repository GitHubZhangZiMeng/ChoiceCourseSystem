//
//  YearClassVC.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "YearClassVC.h"
#import "PersonTableViewCell.h"
#import "MajorViewController.h"
@interface YearClassVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *yearClassArr;

@end

@implementation YearClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择年级";
    //根据学院名 来访问
    self.yearClassArr = [NSArray arrayWithObjects:@"2012届",@"2013届",@"2014届",@"2015届", nil];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MajorViewController *vc = [[MajorViewController alloc] init];
    vc.collegeName = self.collegeName;
    vc.yearClass = self.yearClassArr [indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    cell.personRowLab.text = self.yearClassArr[indexPath.row];
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
