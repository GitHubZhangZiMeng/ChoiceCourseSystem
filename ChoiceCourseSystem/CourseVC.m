//
//  CourseVC.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/19.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "CourseVC.h"
#import "PersonTableViewCell.h"
#import "CourseInfoView.h"
#import "CourseInfoTableViewCell.h"

@interface CourseVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *courseInfoArr;
@property (nonatomic,strong)NSArray *classArr;
@property (nonatomic,strong)NSMutableArray *courseTagArr;
@property (nonatomic,strong)IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    _courseInfoArr = [NSArray arrayWithObjects:@"开课时间",@"选课时间",@"开设学院",@"课程时长",@"授课教室", nil];
    _classArr = [NSArray arrayWithObjects:@"信息对抗121",@"信息对抗122",@"信息安全121",@"信息安全122",nil];
    _courseTagArr = [NSMutableArray array];
    _imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%11+1]];
    
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)closeClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerBtnClick:(UIButton *)btn
{
    NSLog(@"%@",_courseTagArr);
    
    for (NSObject *obj in btn.superview.subviews)
    {
        if ([obj isKindOfClass:[UIImageView class]])
        {
            UIImageView *img = (UIImageView *)obj;
            
            if ([_courseTagArr[btn.tag] isEqualToString:@"0"])
            {
                [_courseTagArr replaceObjectAtIndex:btn.tag withObject:@"1"];
                img.image = [UIImage imageNamed:@"down"];
                
            }
            else
            {
                [_courseTagArr replaceObjectAtIndex:btn.tag withObject:@"0"];
                img.image = [UIImage imageNamed:@"in"];
                
            }
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
    
    
    
}


#pragma mark - tableview 代理


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = _courseInfoArr[section];
//    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _courseInfoArr.count;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
      
    }
    cell.textLabel.text = @"123123123123123123123";
    cell.textLabel.textColor = [UIColor grayColor];
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
