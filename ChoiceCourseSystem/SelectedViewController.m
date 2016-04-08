//
//  SelectedViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/6.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SelectedViewController.h"

@interface SelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UIView *tagVi;
@property (nonatomic, strong)UIScrollView *scroll;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程";
    
    
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
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight+StatusHeight+44, MainScreenWidth, MainScreenHeight)];
    _scroll.contentSize = CGSizeMake(MainScreenWidth*2, 0);
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    UITableView *selectedTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    selectedTab.tag = 1;
    selectedTab.delegate = self;
    selectedTab.dataSource = self;
    [_scroll addSubview:selectedTab];
    
    UITableView *notSelectedTab = [[UITableView alloc] initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, MainScreenHeight)];
    notSelectedTab.tag = 2;
    notSelectedTab.backgroundColor = [UIColor redColor];
    notSelectedTab.delegate = self;
    notSelectedTab.dataSource = self;
    [_scroll addSubview:notSelectedTab];
    
    
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

#pragma mark - scroller代理

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0)
    {
        if (scrollView.contentOffset.x == MainScreenWidth)
        {
             _tagVi.frame = CGRectMake(MainScreenWidth/2, 40, MainScreenWidth/2, 4);
        }
        else
        {
            _tagVi.frame = CGRectMake(0, 40, MainScreenWidth/2, 4);
        }
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    _tagVi.frame =CGRectMake(scrollView.contentOffset.x/2, 40, MainScreenWidth/2, 4);
    
}


#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1)//已选课程
    {
         return 0;
    }
    else
    {
         return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        return nil;
    }
    else
    {
        return nil;
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
