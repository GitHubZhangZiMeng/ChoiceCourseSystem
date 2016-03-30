//
//  PersonViewController.h
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *personArr;

@end
