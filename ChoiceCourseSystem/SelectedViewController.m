//
//  SelectedViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/6.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SelectedViewController.h"
#import "PersonTableViewCell.h"
#import "CourseInfoTableViewCell.h"
#import "CourseInfoView.h"
#import "SVPullToRefresh/SVPullToRefresh.h"
#import "ClassViewController.h"
#import "SelectedTableViewCell.h"
#import "SelectingTableViewCell.h"
#import "CourseVC.h"
#import "CourseViewController.h"
#import "MBProgressHUD.h"
@interface SelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MBProgressHUDDelegate>

@property (nonatomic, strong)NSArray *selectArr;
@property (nonatomic, strong)NSMutableArray *seletedTagArr;
@property (nonatomic, strong)NSArray *seledtNotArr;
@property (nonatomic, strong)NSMutableArray *seletedNotTagArr;

@property (nonatomic, strong)UITableView *selectedTab;
@property (nonatomic,strong)UITableView *notSelectedTab;

@property (nonatomic, strong)UIView *tagVi;
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *commitBtn;
@property (nonatomic, strong)NSMutableDictionary *courseDic;

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)MBProgressHUD *hub;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.collegeID);
    self.navigationItem.title=self.collegeName;
    self.courseDic = [[NSMutableDictionary alloc] init];
    self.tabBarController.tabBar.hidden = YES;

    //请求数

    
    
    UIView *seView = [[UIView alloc] init];
    seView.backgroundColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
    seView.frame = CGRectMake(0 , NavHeight+StatusHeight, MainScreenWidth, 44);
    [self.view addSubview:seView];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_leftBtn setTitle:@"已选课程" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftBtn setFrame:CGRectMake(0, 0, MainScreenWidth/2, 40)];
    _leftBtn.tag = 1;
    [_leftBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seView addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.tag = 2;
    [_rightBtn setTitle:@"未选课程" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_rightBtn setFrame:CGRectMake(MainScreenWidth/2, 0, MainScreenWidth/2, 40)];
    [_rightBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seView addSubview:_rightBtn];
    
    _tagVi = [[UIView alloc] init];
    _tagVi.frame = CGRectMake(0, 40, MainScreenWidth/2, 4);
    _tagVi.backgroundColor = [UIColor whiteColor];
    [seView addSubview:_tagVi];
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight+StatusHeight+44, MainScreenWidth, MainScreenHeight- NavHeight-StatusHeight-44)];
    _scroll.contentSize = CGSizeMake(MainScreenWidth*2, 0);
    _scroll.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    
    SVPullToRefreshView  *svPullView = [[SVPullToRefreshView alloc] init];
    [svPullView setTitle:@"123" forState:SVPullToRefreshStateTriggered];
    
    _selectedTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, _scroll.bounds.size.height) style:UITableViewStylePlain];
    _selectedTab.tag = 1;
    _selectedTab.delegate = self;
    _selectedTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectedTab.dataSource = self;
    _selectedTab.showsVerticalScrollIndicator = NO;
    
    __weak SelectedViewController *weakself= self;
    [_selectedTab addPullToRefreshWithActionHandler:^{
        //刷新数据 表
        [weakself tab1pulltoRefresh];
        
    }];
    [_scroll addSubview:_selectedTab];
    
    _notSelectedTab = [[UITableView alloc] initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, _scroll.bounds.size.height) style:UITableViewStylePlain];
    _notSelectedTab.tag = 2;
    _notSelectedTab.delegate = self;
    _notSelectedTab.dataSource = self;
    _notSelectedTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _notSelectedTab.showsVerticalScrollIndicator = NO;
    [_scroll addSubview:_notSelectedTab];
    [_notSelectedTab addPullToRefreshWithActionHandler:^{
        [weakself tab2pulltoRefresh];
    }];
    
//    _commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    _commitBtn.hidden = YES;
//    _commitBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:0.7];
//    [_commitBtn setTitle:@"提交选课" forState:UIControlStateNormal];
//    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_commitBtn setFrame:CGRectMake(MainScreenWidth, MainScreenHeight-NavHeight-StatusHeight-44-44, MainScreenWidth, 44)];
//    [_commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
//    [_scroll addSubview:_commitBtn];
//    [_scroll bringSubviewToFront:_commitBtn];
    
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
   [self.navigationController setNavigationBarHidden:NO];
    _hub = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hub];
    
    _hub.delegate = self;
    _hub.labelText = @"加载中...";
    
    [_hub showWhileExecuting:@selector(loadCourseData) onTarget:self withObject:nil animated:YES];
    
}

#pragma mark - 加载数据
- (void)loadCourseData
{
    
    [NetHelper postRequest:kURL_selectable withActionStr:@"selected" withDataStr:[NSString stringWithFormat:@"{\"collegeid\":\"%@\"}",self.collegeID] withNetBlock:^(id responseObject) {
        NSLog(@"%@",self.collegeID);
        NSLog(@"____%@",responseObject);
        _selectArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_selectedTab reloadData];
        });
    } withErrBlock:^(id err) {
        
        
    }];
    
    [NetHelper postRequest:kURL_selectable withActionStr:@"selectable" withDataStr:[NSString stringWithFormat:@"{\"collegeid\":\"%@\"}",self.collegeID] withNetBlock:^(id responseObject) {
        NSLog(@"____%@",responseObject);
        _seledtNotArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_notSelectedTab reloadData];
        });
    } withErrBlock:^(id err) {
        
    }];
    
}


#pragma mark - 下拉刷新
- (void)tab1pulltoRefresh
{
    
//    sleep(2);
    [NetHelper postRequest:kURL_selectable withActionStr:@"selected" withDataStr:[NSString stringWithFormat:@"{\"collegeid\":\"%@\"}",self.collegeID] withNetBlock:^(id responseObject) {
        NSLog(@"%@",self.collegeID);
        NSLog(@"____%@",responseObject);
        _selectArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_selectedTab reloadData];
        });
    } withErrBlock:^(id err) {
        
        
    }];
    
    [self.selectedTab.pullToRefreshView stopAnimating];
    
}

- (void)tab2pulltoRefresh
{
    [NetHelper postRequest:kURL_selectable withActionStr:@"selectable" withDataStr:[NSString stringWithFormat:@"{\"collegeid\":\"%@\"}",self.collegeID] withNetBlock:^(id responseObject) {
        NSLog(@"____%@",responseObject);
        _seledtNotArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_notSelectedTab reloadData];
        });
    } withErrBlock:^(id err) {
        
    }];
    [self.notSelectedTab.pullToRefreshView stopAnimating];
}

#pragma mark - btn的addtarget
- (void)selectBtn: (UIButton *)selectedBtn
{
    if (selectedBtn.tag == 1)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.2];
        _tagVi.frame = CGRectMake(0, 40, MainScreenWidth/2, 4);
        _scroll.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.2];
        _tagVi.frame = CGRectMake(MainScreenWidth/2, 40, MainScreenWidth/2, 4);
         _scroll.contentOffset = CGPointMake(MainScreenWidth, 0);
        [UIView commitAnimations];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}
//- (void)commitClick
//{
//    NSLog(@"____%@",self.courseDic);
//    [AlertNotice showAlert:2 withTitle:@"提示" withContent:[NSString stringWithFormat:@"共选课%lu门，是否进行提交",(unsigned long)self.courseDic.count] withVC:self clickLeftBtn:^{
//        //提交选课
//    } clickRightBtn:^{
//        
//    }];
//    
//}

//- (void)headerClick:(UIButton *)headerBtn
//{
//    if (_scroll.contentOffset.x > 0)
//    {
//        if ([self.seletedNotTagArr[headerBtn.tag] isEqualToString:@"1"])
//        {
//            [self.seletedNotTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"0"];
//        }
//        else
//        {
//            [self.seletedNotTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"1"];
//        }
//        
//        
//        [_notSelectedTab reloadSections:[NSIndexSet indexSetWithIndex:headerBtn.tag] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else
//    {
//        NSLog(@"%lu",(unsigned long)self.seletedTagArr.count);
//        NSLog(@"%ld",(long)headerBtn.tag);
//        if ([self.seletedTagArr[headerBtn.tag] isEqualToString:@"1"])
//        {
//            [self.seletedTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"0"];
//        }
//        else
//        {
//            [self.seletedTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"1"];
//        }
//        
//        [_selectedTab reloadSections:[NSIndexSet indexSetWithIndex:headerBtn.tag] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    
//    
//}
#pragma mark - scroller代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.tag ==0)
    {
         _tagVi.frame =CGRectMake(scrollView.contentOffset.x/2, 40, MainScreenWidth/2, 4);
    }
    
}


#pragma mark - tableView代理

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView.tag==2)
//    {
//         return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//    }
//    else
//    {
//        return UITableViewCellEditingStyleNone;
//    }
//   
//}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1)
    {
        NSLog(@"didSelectRowAtIndexPath");
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        CourseVC *vc = [[CourseVC alloc] init];
        vc.collegeStr = self.collegeName;
        vc.course = [_selectArr[indexPath.row] objectForKey:@"coursename"];
        vc.teach = [_selectArr[indexPath.row] objectForKey:@"username"];
        vc.major = [_selectArr[indexPath.row] objectForKey:@"majorname"];
        vc.openTime = [numFormatter stringFromNumber:[_selectArr[indexPath.row] objectForKey:@"startweek"]];
        vc.totalhour = [numFormatter stringFromNumber:[_selectArr[indexPath.row] objectForKey:@"totalhour"]];
        NSString *yearStr = [NSString stringWithFormat:@"%@级",[_selectArr[indexPath.row] objectForKey:@"gradeyear"]];
        for (int i=0; i<[[_selectArr[indexPath.row] objectForKey:@"class"]count]; i++)
        {
            yearStr = [yearStr stringByAppendingString:[numFormatter stringFromNumber:[[_selectArr[indexPath.row] objectForKey:@"class"][i] objectForKey:@"no"]]];
            yearStr = [yearStr stringByAppendingString:@"班"];
        }
        vc.clas = yearStr;
        [self.navigationController pushViewController:vc animated:YES];
        
//        NSString *str = [NSString stringWithFormat:@"%d",indexPath.section];
//        [self.courseDic setObject:self.seledtNotArr[indexPath.section] forKey:str];
//        NSLog(@"self.courseDic:%@",self.courseDic);
//        [_commitBtn setTitle:[NSString stringWithFormat:@"提交选课(%d)",self.courseDic.count] forState:UIControlStateNormal];
//        if (self.courseDic.count !=0)
//        {
//            self.commitBtn.hidden = NO;
//        }
    }
    
   else
   {
       NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
       CourseViewController *vc = [[CourseViewController alloc] init];
       vc.teachingscheduleid = [_seledtNotArr[indexPath.row] objectForKey:@"teachingscheduleid"];
       vc.collegeName = self.collegeName;
       vc.courseName = [_seledtNotArr[indexPath.row] objectForKey:@"coursename"];
       vc.major = [_seledtNotArr[indexPath.row] objectForKey:@"majorname"];
       vc.openTime = [numFormatter stringFromNumber:[_seledtNotArr[indexPath.row] objectForKey:@"startweek"]];
       vc.totalhour = [numFormatter stringFromNumber:[_seledtNotArr[indexPath.row] objectForKey:@"totalhour"]];
       NSString *yearStr = [NSString stringWithFormat:@"%@级",[_seledtNotArr[indexPath.row] objectForKey:@"gradeyear"]];
       for (int i=0; i<[[_seledtNotArr[indexPath.row] objectForKey:@"class"]count]; i++)
       {
           yearStr = [yearStr stringByAppendingString:[numFormatter stringFromNumber:[[_seledtNotArr[indexPath.row] objectForKey:@"class"][i] objectForKey:@"no"]]];
           yearStr = [yearStr stringByAppendingString:@"班"];
       }
       vc.clas = yearStr;
       [self.navigationController pushViewController:vc animated:YES];
       
   }
    
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView.tag==2)
//    {
//        NSLog(@"didDeselectRowAtIndexPath");
//        NSString *str = [NSString stringWithFormat:@"%d",indexPath.section];
//        [self.courseDic removeObjectForKey:str];
//        [_commitBtn setTitle:[NSString stringWithFormat:@"提交选课(%d)",self.courseDic.count] forState:UIControlStateNormal];
//        if (self.courseDic.count==0)
//        {
//            self.commitBtn.hidden = YES;
//        }
//
//    }
//}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if (tableView.tag == 1)
//    {
//        return self.selectArr.count;
//    }
//    else
//    {
//        return self.seledtNotArr.count;
//    }
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (tableView.tag ==1)
//    {
//        CourseInfoView *infoView = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoView" owner:nil options:nil][0];
//        infoView.headerBtn.tag = section;
//        [infoView.headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        infoView.CourseNameLab.text = self.selectArr[section];
//        for (NSObject *obj in infoView.subviews)
//        {
//            if ([obj isKindOfClass:[UIImageView class]])
//            {
//                UIImageView *img = (UIImageView *)obj;
//                if ([self.seletedTagArr[section] isEqualToString:@"1"])
//                {
//                    img.image = [UIImage imageNamed:@"down"];
//                }
//                else
//                {
//                    img.image = [UIImage imageNamed:@"in"];
//                }
//                break;
//            }
//        }
//        return infoView;
//    }
//    else
//    {
//        CourseInfoView *infoView = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoView" owner:nil options:nil][0];
//        infoView.headerBtn.tag = section;
//        [infoView.headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        infoView.CourseNameLab.text = self.seledtNotArr[section];
//        for (NSObject *obj in infoView.subviews)
//        {
//            if ([obj isKindOfClass:[UIImageView class]])
//            {
//                UIImageView *img = (UIImageView *)obj;
//                if ([self.seletedNotTagArr[section] isEqualToString:@"1"])
//                {
//                    img.image = [UIImage imageNamed:@"down"];
//                }
//                else
//                {
//                    img.image = [UIImage imageNamed:@"in"];
//                }
//                break;
//            }
//        }
//        return infoView;
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
//        if ([self.seletedTagArr[section] isEqualToString:@"1"])
//        {
//            return 1;
//        }
//        else
//        {
//            return 0;
//        }
        return _selectArr.count;
    }
    else
    {
//        if ([self.seletedNotTagArr[section] isEqualToString:@"1"])
//        {
//            return 1;
//        }
//        else
//        {
//            return 0;
//        }
        return _seledtNotArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        SelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectedCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SelectedTableViewCell" owner:nil options:nil][0];
        }
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        cell.courseNameLab.text = [_selectArr[indexPath.row] objectForKey:@"coursename"];
        cell.courseNameLab.adjustsFontSizeToFitWidth = YES;
        cell.openTimeLab.text = [NSString stringWithFormat:@"第%@周开课",[numFormatter stringFromNumber:[_selectArr[indexPath.row] objectForKey:@"startweek"]]];
        cell.courseTeacherLab.text = [_selectArr[indexPath.row]objectForKey:@"username"];
        NSString *yearStr = [_selectArr[indexPath.row]objectForKey:@"majorname"];
        yearStr = [yearStr stringByAppendingString:[_selectArr[indexPath.row]objectForKey:@"gradeyear"]];
        yearStr = [yearStr stringByAppendingString:@"级"];
        for (int i=0; i<[[_selectArr[indexPath.row] objectForKey:@"class"]count]; i++)
        {
            NSLog(@"%@",yearStr);
            
            yearStr = [yearStr stringByAppendingString:[numFormatter stringFromNumber:[[_selectArr[indexPath.row] objectForKey:@"class"][i] objectForKey:@"no"]]];
            yearStr = [yearStr stringByAppendingString:@"班"];
        }
        cell.courseTimeLab.text = yearStr;
        cell.courseTimeLab.adjustsFontSizeToFitWidth = YES;
        return cell;
        
    }
    
    else
    {
        SelectingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectingCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SelectingTableViewCell" owner:nil options:nil][0];
        }
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        cell.courseNameLab.text = [_seledtNotArr[indexPath.row] objectForKey:@"coursename"];
        cell.courseNameLab.adjustsFontSizeToFitWidth = YES;
        cell.selectTimeLab.text = [_seledtNotArr[indexPath.row] objectForKey:@"majorname"];
        cell.selectTimeLab.adjustsFontSizeToFitWidth = YES;
        NSString *yearStr = [_seledtNotArr[indexPath.row]objectForKey:@"gradeyear"];
        yearStr = [yearStr stringByAppendingString:@"级"];
        for (int i=0; i<[[_seledtNotArr[indexPath.row] objectForKey:@"class"]count]; i++)
        {
            NSLog(@"%@",yearStr);
            
            yearStr = [yearStr stringByAppendingString:[numFormatter stringFromNumber:[[_seledtNotArr[indexPath.row] objectForKey:@"class"][i] objectForKey:@"no"]]];
            yearStr = [yearStr stringByAppendingString:@"班"];
        }
        cell.courseAllTimeLab.text = yearStr;
        
        return cell;
    }
   
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
