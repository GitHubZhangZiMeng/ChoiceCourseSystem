//
//  choiceCourseViewController.h
//  ChoiceCourseSystem
//
//  Created by zzm on 16/3/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceCourseViewController : SuperViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *collegeTable;

@end
