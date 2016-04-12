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
@interface SelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *selectArr;
@property (nonatomic, strong)NSArray *seledtNotArr;
@property (nonatomic, strong)UIView *tagVi;
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)CourseInfoView *infoView;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择课程";
    
    //请求数据
//    self.selectArr = [NSArray arrayWithObjects:@"大学英语",@"高等数学",@"工程导论", nil];
    self.seledtNotArr = [NSArray arrayWithObjects:@"人生规划教育",@"思想道德修养和法律基础",@"体育1",@"网页制作",@"线性代数A", nil];
    if(self.selectArr.count==0)
    {
        [AlertNotice showAlertNotType:@"提示" withContent:@"您还没有选课，请尽快去选课" withVC:self clickLeftBtn:^{
            
        }];
    }
    
    
    UIView *seView = [[UIView alloc] init];
    seView.backgroundColor = [UIColor greenColor];
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
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    UITableView *selectedTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, _scroll.bounds.size.height)];
    selectedTab.tag = 1;
    selectedTab.delegate = self;
    selectedTab.dataSource = self;
    [_scroll addSubview:selectedTab];
    
    UITableView *notSelectedTab = [[UITableView alloc] initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, _scroll.bounds.size.height)];
    notSelectedTab.tag = 2;
    notSelectedTab.delegate = self;
    notSelectedTab.dataSource = self;
    notSelectedTab.editing = YES;
    [_scroll addSubview:notSelectedTab];
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    commitBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:146/255.0 blue:8/255.0 alpha:0.7];
    [commitBtn setTitle:@"提交选课" forState:UIControlStateNormal];
    [commitBtn setFrame:CGRectMake(MainScreenWidth, MainScreenHeight-NavHeight-StatusHeight-44-44, MainScreenWidth, 44)];
    [commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:commitBtn];
    [_scroll bringSubviewToFront:commitBtn];
    
    
    // Do any additional setup after loading the view.
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
    
    
    
}

- (void)headerClick:(UIButton *)headerBtn
{
    for (NSObject *obj in headerBtn.superview.subviews)
    {
        if ([obj isKindOfClass:[UIImageView class]])
        {
            UIImageView *img = (UIImageView *)obj;
            CGAffineTransform rotate = CGAffineTransformMakeRotation( 90.0 / 180.0 * 3.14 );
            [img setTransform:rotate];
        }
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
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.infoView = [[CourseInfoView alloc] init];
    self.infoView.headerBtn.tag = section;
    [self.infoView.headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    if (tableView.tag ==1)
    {
        self.infoView.CourseNameLab.text = self.selectArr[section];
    }
    else
    {
        self.infoView.CourseNameLab.text = self.seledtNotArr[section];
    }
    
    return self.infoView;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoTableViewCell" owner:nil options:nil][0];
    }
    
    if (tableView.tag == 1)
    {
        
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
