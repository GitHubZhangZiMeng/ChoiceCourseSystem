//
//  PersonViewController.h
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray *personArr;

@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *college;
@property (nonatomic, strong)NSString *numble;
@property (nonatomic, strong)NSString *schoolArea;

@end
