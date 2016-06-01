//
//  CancelCourseViewController.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "CancelCourseViewController.h"
#import "CourseInfoTableViewCell.h"
#import "CourseInfoView.h"
#import "CancelCourseView.h"

@interface CancelCourseViewController () <UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, strong)NSMutableArray *courseArr;
@property (nonatomic, strong)NSMutableArray *courseTagArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSMutableDictionary *cancelDic;
@property (nonatomic, strong)UIBarButtonItem *rightBar;
@property (nonatomic, strong)NSMutableArray *suoYingArr;

@end

@implementation CancelCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"退选课程";
    
    _rightBar = [[UIBarButtonItem alloc] initWithTitle:@"确定退选" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    _rightBar.enabled = NO;
    self.navigationItem.rightBarButtonItem = _rightBar;
    
    
    
    _cancelDic = [NSMutableDictionary dictionary];
    
    MBProgressHUD *hub =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    hub.delegate = self;
    hub.labelText = @"加载中...";
    [hub showWhileExecuting:@selector(loadData) onTarget:self withObject:nil animated:YES];
    
    _courseArr = [NSMutableArray arrayWithObjects:@"C语言",@"C++面向对象编程",@"J2EE编程技术",@"网路编程技术",@"大学英语",@"汇编基础",@"数据结构",@"计算机基础",@"计算机网络", nil];
    _tableView.sectionIndexColor = [UIColor grayColor];
    
//    _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    _courseTagArr = [NSMutableArray array];
    
    for (int i=0; i<_courseArr.count; i++)
    {
        [_courseTagArr addObject:@"0"];
    }
    
    _suoYingArr = [NSMutableArray array];
    
    
    NSArray *sequenceArr = [_courseArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    _courseArr = [NSMutableArray arrayWithArray:sequenceArr];
    NSLog(@"___%@",_courseArr);
    
    NSMutableArray *fristArr = [NSMutableArray array];
    
    for (int i = 0; i < _courseArr.count;i++)
    {
        [fristArr addObject:[self firstCharactor:_courseArr[i]]];
    }
    NSLog(@"___%@",fristArr);
    
    for (int i = 0 ; i< fristArr.count; i++)
    {
        if ([fristArr[i] isEqualToString:@""])
        {
            
        }
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData
{
    [NetHelper postRequest:kURL_selectable withActionStr:@"history" withDataStr:[NSString stringWithFormat:@"{\"userid\":\"%@\"}",self.userid] withNetBlock:^(id responseObject) {
        
    } withErrBlock:^(id err) {
        
    }];
}

- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

- (void)rightClick
{
    [AlertNotice showAlert:3 withTitle:nil withContent:[NSString stringWithFormat:@"共退选%lu门课程，是否确定退选",(unsigned long)_cancelDic.count] withVC:self clickLeftBtn:^{
        //确定退选
        MBProgressHUD *hub =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hub];
        hub.delegate = self;
        hub.labelText = @"加载中...";
        [hub showWhileExecuting:@selector(commitCancal) onTarget:self withObject:nil animated:YES];
        
        _rightBar.enabled = NO;
        
        for (NSString *str in [_cancelDic allKeys])
        {
            [_courseArr removeObjectAtIndex:[str intValue]];
        }
        
        [_cancelDic removeAllObjects];
        [_tableView reloadData];
        
    } clickRightBtn:^{
        
    }];
    
}
- (void)commitCancal
{
    
//    [NetHelper postRequest:kURL_selectCollege withActionStr:@"giveup" withDataStr:<#(NSString *)#> withNetBlock:^(id responseObject) {
//        
//    } withErrBlock:^(id err) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tagBtnClick:(UIButton *)btn
{
    superBtn *sBtn = (superBtn *)btn;
    if (!sBtn.isClike)
    {
        sBtn.isClike = YES;
        for (UIView *obj in btn.superview.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]] && obj.tag==1)
            {
                UIImageView *imgView = (UIImageView *)obj;
                imgView.image = [UIImage imageNamed:@"checkbox-selected"];
                
            }
            
        }
        
        
        [_cancelDic setObject:@"" forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        if (_cancelDic.count==0)
        {
            _rightBar.enabled = NO;
        }
        else
        {
            _rightBar.enabled = YES;
        }
        
    }
    else
    {
        sBtn.isClike = NO;
        for (UIView *obj in btn.superview.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]] && obj.tag==1)
            {
                UIImageView *imgView = (UIImageView *)obj;
                imgView.image = [UIImage imageNamed:@"checkbox-normal"];
            }
            
        }
        
        [_cancelDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        if (_cancelDic.count==0)
        {
            _rightBar.enabled = NO;
        }
        else
        {
            _rightBar.enabled = YES;
        }
    }
    
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_cancelDic setObject:_courseArr[indexPath.section] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
//    if (_cancelDic.count==0)
//    {
//        _rightBar.enabled = NO;
//    }
//    else
//    {
//        _rightBar.enabled = YES;
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_cancelDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
//    
//    if (_cancelDic.count==0)
//    {
//        _rightBar.enabled = NO;
//    }
//    else
//    {
//        _rightBar.enabled = YES;
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    for(char i = 'A';i <= 'Z';i++)
//    {
//        [_suoYingArr addObject:[NSString stringWithFormat:@"%c",i]];
//    }
//    return _suoYingArr;
//   
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    NSLog(@"%@,%d",title,index);
//    return 1;
//}

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
    CancelCourseView *vi = [[NSBundle mainBundle] loadNibNamed:@"CancelCourseView" owner:nil options:nil][0];
    vi.CourseNameLab.text = _courseArr[section];
    vi.headerBtn.tag = section;
    [vi.headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    vi.tagBtn.tag = section;
    [vi.tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([_cancelDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]])
    {
        for (UIView *obj in vi.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]] && obj.tag==1)
            {
                UIImageView *imgView = (UIImageView *)obj;
                imgView.image = [UIImage imageNamed:@"checkbox-selected"];
                
            }
            
        }
        vi.tagBtn.isClike = YES;
    }
    else
    {
        for (UIView *obj in vi.subviews)
        {
            if ([obj isKindOfClass:[UIImageView class]] && obj.tag==1)
            {
                UIImageView *imgView = (UIImageView *)obj;
                imgView.image = [UIImage imageNamed:@"checkbox-normal"];
            }
            
        }
    }
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
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
