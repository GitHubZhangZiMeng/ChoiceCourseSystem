//
//  ClassViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "ClassViewController.h"
#import "PersonTableViewCell.h"
#import "CourseViewController.h"
#import "SelectedViewController.h"
@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *classArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic ,strong)NSMutableDictionary *dic;
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择班级";
    _tableView.editing = YES;
    self.classArr = [NSArray arrayWithObjects:@"2012届1班",@"2012届2班",@"2012届3班",@"2012届4班",@"2012届5班", nil];
    [_commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    
    _dic = [NSMutableDictionary dictionary];
    _commitBtn.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)commitClick
{
    NSLog(@"____%@",self.dic);
    [AlertNotice showAlert:2 withTitle:@"提示" withContent:[NSString stringWithFormat:@"共选中%d个班级，是否进行提交",self.dic.count] withVC:self clickLeftBtn:^{
        //提交选课
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } clickRightBtn:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dic setObject:_classArr[indexPath.row] forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if (_dic.count !=0)
    {
        _commitBtn.hidden = NO;
    }
    else
    {
        _commitBtn.hidden = YES;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dic removeObjectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    if (_dic.count != 0)
    {
        _commitBtn.hidden = NO;
    }
    else
    {
         _commitBtn.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.classArr[indexPath.row];
    
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
