//
//  SelectingTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/22.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *selectTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *courseAllTimeLab;

@end
