//
//  MajorViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "MajorViewController.h"
#import "PersonTableViewCell.h"
#import "ClassViewController.h"
@interface MajorViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSArray *majorArr;

@end

@implementation MajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择专业";
    
    self.majorArr = [NSArray arrayWithObjects:@"网络工程",@"物联网工程",@"信息安全工程",@"信息对抗工程", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassViewController *vc = [[ClassViewController alloc] init];
    vc.collegeName = self.collegeName;
    vc.yearClass = self.yearClass;
    vc.major = self.majorArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.majorArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    cell.personRowLab.text = self.majorArr[indexPath.row];
    
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
