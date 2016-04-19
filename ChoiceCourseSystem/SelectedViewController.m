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
@interface SelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

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


@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择课程";
    self.courseDic = [[NSMutableDictionary alloc] init];
    

    //请求数据
    self.selectArr = [NSArray arrayWithObjects:@"大学英语",@"高等数学",@"工程导论", nil];
    self.seledtNotArr = [NSArray arrayWithObjects:@"人生规划教育",@"思想道德修养和法律基础",@"体育1",@"网页制作",@"线性代数A", nil];
    self.seletedNotTagArr = [NSMutableArray array];
    self.seletedTagArr = [NSMutableArray array];
    
    for (int i=0; i<self.seledtNotArr.count; i++)
    {
        [self.seletedNotTagArr addObject:@"0"];
    }
    
    NSLog(@"%d",self.selectArr.count);
    
    for (int i=0; i<self.selectArr.count; i++)
    {
        [self.seletedTagArr addObject:@"0"];
    }
     NSLog(@"%d",self.seletedTagArr.count);
    
    
    if(self.selectArr.count==0)
    {
        [AlertNotice showAlertNotType:@"提示" withContent:@"您还没有选课，请尽快去选课" withVC:self clickLeftBtn:^{
            
        }];
    }
    
    
    UIView *seView = [[UIView alloc] init];
    seView.backgroundColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:1];
    seView.frame = CGRectMake(0 , NavHeight+StatusHeight, MainScreenWidth, 44);
    [self.view addSubview:seView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setTitle:@"已选课程" forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, MainScreenWidth/2, 40)];
    leftBtn.tag = 1;
    [leftBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.tag = 2;
    [rightBtn setTitle:@"未选课程" forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(MainScreenWidth/2, 0, MainScreenWidth/2, 40)];
    [rightBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seView addSubview:rightBtn];
    
    _tagVi = [[UIView alloc] init];
    _tagVi.frame = CGRectMake(0, 40, MainScreenWidth/2, 4);
    _tagVi.backgroundColor = [UIColor grayColor];
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
    _notSelectedTab.showsVerticalScrollIndicator = NO;
    [_scroll addSubview:_notSelectedTab];
    
    
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
#pragma mark - 下拉刷新
- (void)tab1pulltoRefresh
{
    
//    sleep(2);
    [self.selectedTab reloadData];
    [self.selectedTab.pullToRefreshView stopAnimating];
    
}

- (void)tab2pulltoRefresh
{
    [self.notSelectedTab reloadData];
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
        
      
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.2];
        _tagVi.frame = CGRectMake(MainScreenWidth/2, 40, MainScreenWidth/2, 4);
         _scroll.contentOffset = CGPointMake(MainScreenWidth, 0);
        [UIView commitAnimations];
    }
}
- (void)commitClick
{
    NSLog(@"____%@",self.courseDic);
    [AlertNotice showAlert:2 withTitle:@"提示" withContent:[NSString stringWithFormat:@"共选课%d门，是否进行提交",self.courseDic.count] withVC:self clickLeftBtn:^{
        //提交选课
    } clickRightBtn:^{
        
    }];
    
}

- (void)headerClick:(UIButton *)headerBtn
{
    if (_scroll.contentOffset.x>0)
    {
        if ([self.seletedNotTagArr[headerBtn.tag] isEqualToString:@"1"])
        {
            [self.seletedNotTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"0"];
        }
        else
        {
            [self.seletedNotTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"1"];
        }
        
        
        [_notSelectedTab reloadSections:[NSIndexSet indexSetWithIndex:headerBtn.tag] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        NSLog(@"%d",self.seletedTagArr.count);
        NSLog(@"%d",headerBtn.tag);
        if ([self.seletedTagArr[headerBtn.tag] isEqualToString:@"1"])
        {
            [self.seletedTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"0"];
        }
        else
        {
            [self.seletedTagArr replaceObjectAtIndex:headerBtn.tag withObject:@"1"];
        }
        
        [_selectedTab reloadSections:[NSIndexSet indexSetWithIndex:headerBtn.tag] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
}
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
         return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleNone;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        NSLog(@"didSelectRowAtIndexPath");
        ClassViewController *classVC = [[ClassViewController alloc] init];
        classVC.collegeName = self.collegeName;
        classVC.courseName = _seledtNotArr[indexPath.section];
        [self.navigationController pushViewController:classVC animated:YES];
        
//        NSString *str = [NSString stringWithFormat:@"%d",indexPath.section];
//        [self.courseDic setObject:self.seledtNotArr[indexPath.section] forKey:str];
//        NSLog(@"self.courseDic:%@",self.courseDic);
//        [_commitBtn setTitle:[NSString stringWithFormat:@"提交选课(%d)",self.courseDic.count] forState:UIControlStateNormal];
//        if (self.courseDic.count !=0)
//        {
//            self.commitBtn.hidden = NO;
//        }
    }
   
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        NSLog(@"didDeselectRowAtIndexPath");
        NSString *str = [NSString stringWithFormat:@"%d",indexPath.section];
        [self.courseDic removeObjectForKey:str];
        [_commitBtn setTitle:[NSString stringWithFormat:@"提交选课(%d)",self.courseDic.count] forState:UIControlStateNormal];
        if (self.courseDic.count==0)
        {
            self.commitBtn.hidden = YES;
        }

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1)
    {
        return self.selectArr.count;
    }
    else
    {
        return self.seledtNotArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag ==1)
    {
        CourseInfoView *infoView = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoView" owner:nil options:nil][0];
        infoView.headerBtn.tag = section;
        [infoView.headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];

        infoView.CourseNameLab.text = self.selectArr[section];
        for (NSObject *obj in infoView.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]])
            {
                UIImageView *img = (UIImageView *)obj;
                if ([self.seletedTagArr[section] isEqualToString:@"1"])
                {
                    img.image = [UIImage imageNamed:@"down"];
                }
                else
                {
                    img.image = [UIImage imageNamed:@"in"];
                }
                break;
            }
        }
        return infoView;
    }
    else
    {
        CourseInfoView *infoView = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoView" owner:nil options:nil][0];
        infoView.headerBtn.tag = section;
        [infoView.headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];

        infoView.CourseNameLab.text = self.seledtNotArr[section];
        for (NSObject *obj in infoView.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]])
            {
                UIImageView *img = (UIImageView *)obj;
                if ([self.seletedNotTagArr[section] isEqualToString:@"1"])
                {
                    img.image = [UIImage imageNamed:@"down"];
                }
                else
                {
                    img.image = [UIImage imageNamed:@"in"];
                }
                break;
            }
        }
        return infoView;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        if ([self.seletedTagArr[section] isEqualToString:@"1"])
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
    }
    else
    {
        if ([self.seletedNotTagArr[section] isEqualToString:@"1"])
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoTableViewCell" owner:nil options:nil][0];
        cell.courseStart.adjustsFontSizeToFitWidth = YES;
    }
    
    
    if (tableView.tag == 1)
    {
        cell.inImgView.hidden = YES;
        return cell;
    }
    
    else
    {
        
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
