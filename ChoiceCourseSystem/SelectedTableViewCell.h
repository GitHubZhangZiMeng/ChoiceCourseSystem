//
//  SelectedTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/22.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLab;

@end
