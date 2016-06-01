//
//  MyCourseVC.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/18.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "MyCourseVC.h"
#import "CourseInfoTableViewCell.h"
#import "CourseInfoView.h"
@interface MyCourseVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, strong)NSArray *courseArr;
@property (nonatomic, strong)NSMutableArray *courseTagArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD *hub =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    hub.delegate = self;
    hub.labelText = @"加载中...";
    [hub showWhileExecuting:@selector(loadData) onTarget:self withObject:nil animated:YES];
    NSLog(@"userid:%@---",self.userid);
    
//    _courseArr = [NSArray arrayWithObjects:@"C语言",@"C++面向对象编程",@"J2EE编程技术", nil];
//    _courseTagArr = [NSMutableArray array];
//    for (int i=0; i<_courseArr.count; i++)
//    {
//        [_courseTagArr addObject:@"0"];
//    }
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    __weak UITableView *weakTableView = _tableView;
    [NetHelper postRequest:kURL_selectable withActionStr:@"history" withDataStr:[NSString stringWithFormat:@"{\"userid\":\"%@\"}",self.userid] withNetBlock:^(id responseObject) {
        
        _courseArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        _courseTagArr = [NSMutableArray array];
        for (int i=0; i<_courseArr.count; i++)
        {
            [_courseTagArr addObject:@"0"];
        }
        [weakTableView reloadData];

    } withErrBlock:^(id err) {
        
    }];
    
}

- (void)headerBtnClick:(UIButton *)btn
{
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CourseInfoView *vi = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoView" owner:nil options:nil][0];
    vi.CourseNameLab.text = [_courseArr[section] objectForKey:@"coursename"];
    vi.headerBtn.tag = section;
    [vi.headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([_courseTagArr[section] isEqualToString:@"1"])
    {
        vi.inImgView.image = [UIImage imageNamed:@"down"];
    }
    else
    {
        vi.inImgView.image = [UIImage imageNamed:@"in"];
    }
    return vi;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _courseArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_courseTagArr[section] isEqualToString:@"1"])
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoTableViewCell" owner:nil options:nil][0];
    }
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    cell.collegeName.text = [_courseArr[indexPath.section] objectForKey:@"collegename"];
    cell.maiorName.text = [_courseArr[indexPath.section] objectForKey:@"majorname"];
    cell.openTime.text = [NSString stringWithFormat:@"第%@周", [numFormatter stringFromNumber:[_courseArr[indexPath.section] objectForKey:@"startweek"]]];
    cell.gradeyear.text = [_courseArr[indexPath.section]objectForKey:@"gradeyear"];
    cell.totalhour.text = [numFormatter stringFromNumber:[_courseArr[indexPath.section]objectForKey:@"totalhour"]];
    NSString *clasStr = [NSString string];
    
    for (int i=0; i<[[_courseArr[indexPath.section] objectForKey:@"class"]count]; i++)
    {
        NSLog(@"%@",clasStr);
        
        clasStr = [clasStr stringByAppendingString:[numFormatter stringFromNumber:[[_courseArr[indexPath.row] objectForKey:@"class"][i] objectForKey:@"no"]]];
        clasStr = [clasStr stringByAppendingString:@"班"];
    }
    
    cell.courseClass.text = clasStr;
    NSLog(@"%@,%@,%@,%@,%@",cell.collegeName.text,cell.maiorName.text,cell.openTime.text,cell.gradeyear.text,cell.totalhour.text);
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
