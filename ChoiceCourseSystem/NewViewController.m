//
//  NewViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/25.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "NewViewController.h"
#import "NewTableViewCell.h"

@interface NewViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"school"]];
    return img;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cuitbeijing"]];
    return img;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 210;
            break;
        case 1:
            return 260;
            break;
        case 2:
            return 300;
            break;
        default:
            break;
    }
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTableViewCell *cell;
    switch (indexPath.row)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][0];
            }
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][1];
            }
        }
            
            break;
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][2];
            }
        }
            
            break;
            
        default:
            break;
    }
    
   
    
    return cell;
}


@end
