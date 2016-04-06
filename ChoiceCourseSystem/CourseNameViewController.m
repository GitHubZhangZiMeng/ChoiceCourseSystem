//
//  CourseNameViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/6.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "CourseNameViewController.h"
#import "PersonTableViewCell.h"
@interface CourseNameViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CourseNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:MainScreen.bounds style:UITableViewStyleGrouped];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
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
        cell = [[NSBundle mainBundle]loadNibNamed:@"PersonTableViewCell" owner:nil options:nil][0];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
