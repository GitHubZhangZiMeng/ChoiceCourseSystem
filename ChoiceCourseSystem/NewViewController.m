//
//  NewViewController.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/25.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "NewViewController.h"
#import "NewTableViewCell.h"
#import "MBProgressHUD.h"
#import "CancelCourseViewController.h"

@interface NewViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTableview;

@property (nonatomic, strong)MBProgressHUD *hub;

@property (nonatomic, strong)NSArray *newsArr;

@property (nonatomic, strong)NSMutableArray *collegeArr;

@property (nonatomic, strong)NSMutableArray *collegeNum;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    hub.delegate = self;
    hub.labelText = @"加载中...";
    [hub showWhileExecuting:@selector(loadNewCourse) onTarget:self withObject:nil animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNewCourse
{
    [NetHelper postRequest:kURL_selectable withActionStr:@"news" withDataStr:@"{\"year\":\"\"}" withNetBlock:^(id responseObject) {
        
        NSLog(@"responseObject___%@",responseObject);
        _newsArr = [NSArray arrayWithArray:[responseObject objectForKey:@"teachingschedules"]];
        _collegeArr = [NSMutableArray array];
        _collegeNum = [NSMutableArray array];
        
        for (int i = 0 ; i < _newsArr.count; i++)
        {
            NSString *time = [_newsArr[i]objectForKey:@"time"];
            NSString *date = [time componentsSeparatedByString:@" "][0];
        }
        
        for (int i = 0; i < _newsArr.count; i++)
        {
            if (i==0)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0] forKey:@"time"];
                [dic setObject:[_newsArr[i] objectForKey:@"collegename"] forKey:@"collegename"];
                [_collegeArr addObject:dic];
                NSLog(@"_collegeArr   :%@",_collegeArr);
            }
            else
            {
                BOOL notNave = YES;
                for (int j = 0; j<_collegeArr.count; j++)
                {
                    if ([[_newsArr[i] objectForKey:@"collegename"] isEqualToString:[_collegeArr[j] objectForKey:@"collegename"]]&&[[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0] isEqualToString:[_collegeArr[j] objectForKey:@"time"]])
                    {
                        notNave = NO;
                    }
                    
                }
                if (notNave)
                {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0] forKey:@"time"];
                    [dic setObject:[_newsArr[i] objectForKey:@"collegename"] forKey:@"collegename"];
                    [_collegeArr addObject:dic];
                }
            }
        }
        NSLog(@"%@",_collegeArr);
        for (int i = 0; i < _collegeArr.count; i++)
        {
            int num = 0;
            for (int j = 0;j < _newsArr.count; j++)
            {
                if ([[_newsArr[j] objectForKey:@"collegename"] isEqualToString:[_collegeArr[i] objectForKey:@"collegename"]]&&[[[_newsArr[j] objectForKey:@"time"] componentsSeparatedByString:@" "][0] isEqualToString:[_collegeArr[i] objectForKey:@"time"]])
                {
                    num ++;
                }
            }
            [_collegeNum addObject:[NSString stringWithFormat:@"%d",num]];
        }
        NSLog(@"%@",_collegeNum);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_newsTableview reloadData];
        });
    } withErrBlock:^(id err) {
        
    }];
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
    return _collegeArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([_collegeNum[indexPath.row] integerValue])
    {
        case 1:
            return 210;
            break;
        case 2:
            return 260;
            break;
        default:
            break;
    }
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //cell1
//    @property (weak, nonatomic) IBOutlet UILabel *timeLab1;
//    @property (weak, nonatomic) IBOutlet UILabel *collegeName1;
//    @property (weak, nonatomic) IBOutlet UILabel *fristLab1;
//    @property (weak, nonatomic) IBOutlet UIButton *infoBtn1;
//    
//    
//    
//    //cell2
//    @property (weak, nonatomic) IBOutlet UILabel *timeLab2;
//    @property (weak, nonatomic) IBOutlet UILabel *collegeName2;
//    @property (weak, nonatomic) IBOutlet UILabel *fristLab2;
//    @property (weak, nonatomic) IBOutlet UILabel *secondLab2;
//    @property (weak, nonatomic) IBOutlet UIButton *infoBtn2;
//    
//    
//    //cell3
//    
//    @property (weak, nonatomic) IBOutlet UILabel *timeLab3;
//    @property (weak, nonatomic) IBOutlet UILabel *collegeName3;
//    @property (weak, nonatomic) IBOutlet UILabel *fristLab3;
//    @property (weak, nonatomic) IBOutlet UILabel *secondLab3;
//    @property (weak, nonatomic) IBOutlet UILabel *trirdLab3;
//    @property (weak, nonatomic) IBOutlet UIButton *infoBtn3;
    NewTableViewCell *cell;
    switch ([_collegeNum[indexPath.row] integerValue])
    {
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][0];
            }
            if([[_collegeArr[indexPath.row] objectForKey:@"time"] length] > 4)
            {
                cell.timeLab1.text = [[_collegeArr[indexPath.row] objectForKey:@"time"] substringFromIndex:5];
            }
            else
            {
                cell.timeLab1.text = @"5/3";
            }
            
            cell.collegeName1.text = [_collegeArr[indexPath.row] objectForKey:@"collegename"];
            cell.infoBtn1.tag = indexPath.row;
            [cell.infoBtn1 addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
            for (int i = 0; i<_newsArr.count; i++)
            {
                if ([cell.collegeName1.text isEqualToString:[_newsArr[i] objectForKey:@"collegename"]]&&[[_collegeArr[indexPath.row] objectForKey:@"time"] isEqualToString:[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0]])
                {
                    cell.fristLab1.text = [_newsArr[i] objectForKey:@"coursename"];
                }
            }
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][1];
            }
            if([[_collegeArr[indexPath.row] objectForKey:@"time"] length] > 4)
            {
                cell.timeLab2.text = [[_collegeArr[indexPath.row] objectForKey:@"time"] substringFromIndex:5];
            }
            else
            {
                cell.timeLab2.text = @"5/3";
            }
            cell.collegeName2.text = [_collegeArr[indexPath.row] objectForKey:@"collegename"];
            cell.infoBtn2.tag = indexPath.row;
            [cell.infoBtn2 addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
            int haveCourseNum = 0;
            for (int i = 0; i<_newsArr.count; i++)
            {
                if ([cell.collegeName2.text isEqualToString:[_newsArr[i] objectForKey:@"collegename"]]&&[[_collegeArr[indexPath.row] objectForKey:@"time"] isEqualToString:[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0]])
                {
                    haveCourseNum ++;
                    if (haveCourseNum==1)
                    {
                        cell.fristLab2.text = [_newsArr[i] objectForKey:@"coursename"];
                    }
                    else
                    {
                        cell.secondLab2.text = [_newsArr[i] objectForKey:@"coursename"];
                    }
                }
            }
        }
            
            break;
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:nil options:nil][2];
            }
            if([[_collegeArr[indexPath.row] objectForKey:@"time"] length] > 4)
            {
                cell.timeLab3.text = [[_collegeArr[indexPath.row] objectForKey:@"time"] substringFromIndex:5];
            }
            else
            {
                cell.timeLab3.text = @"5/3";
            }
            cell.timeLab3.text = [[_collegeArr[indexPath.row] objectForKey:@"time"] substringFromIndex:5];
            cell.collegeName3.text = [_collegeArr[indexPath.row] objectForKey:@"collegename"];
            cell.infoBtn3.tag = indexPath.row;
            [cell.infoBtn3 addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
            int haveCourseNum = 0;
            for (int i = 0; i<_newsArr.count; i++)
            {
                if ([cell.collegeName3.text isEqualToString:[_newsArr[i] objectForKey:@"collegename"]]&&[[_collegeArr[indexPath.row] objectForKey:@"time"] isEqualToString:[[_newsArr[i] objectForKey:@"time"] componentsSeparatedByString:@" "][0]])
                {
                    haveCourseNum ++;
                    if (haveCourseNum==1)
                    {
                        cell.fristLab3.text = [_newsArr[i] objectForKey:@"coursename"];
                    }
                    else if(haveCourseNum==2)
                    {
                        cell.secondLab3.text = [_newsArr[i] objectForKey:@"coursename"];
                        NSLog(@"%@",[_newsArr[i] objectForKey:@"coursename"]);
                        NSLog(@"%@",cell.secondLab3.text);
                    }
                    else
                    {
                        cell.trirdLab3.text = [_newsArr[i] objectForKey:@"coursename"];
                    }
                    if (haveCourseNum>=3)
                    {
                        break;
                    }
                }
            }
        }
            break;
    }
    
    return cell;
}

- (void)infoClick:(UIButton *)sender
{
    CancelCourseViewController *vc = [[CancelCourseViewController alloc] init];
    vc.selectableDic = _collegeArr[sender.tag];
    vc.selctableArr = _newsArr;
    NSLog(@"%@",_collegeArr[sender.tag]);
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
