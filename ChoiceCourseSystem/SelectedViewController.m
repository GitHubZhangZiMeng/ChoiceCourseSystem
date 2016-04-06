//
//  SelectedViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/6.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SelectedViewController.h"

@interface SelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UISegmentedControl *segment;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"已选课程",@"未选课程", nil]];
    
    [_segment setSelectedSegmentIndex:0];
    [_segment addTarget:self action:@selector(selectOrNot:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    
    _scroll = [[UIScrollView alloc] initWithFrame:MainScreen.bounds];
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


#pragma mark - 选择segment
- (void)selectOrNot:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex ==0)
    {
        _scroll.contentOffset = CGPointMake(0, 0);
    }
    else
    {
        _scroll.contentOffset = CGPointMake(MainScreenWidth, 0);
    }
}
#pragma mark - scroller代理

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0)
    {
        if (scrollView.contentOffset.x == MainScreenWidth)
        {
            [_segment setSelectedSegmentIndex:1];
        }
        else
        {
            [_segment setSelectedSegmentIndex:0];
        }
    }
    
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
