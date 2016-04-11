//
//  CourseInfoTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *choiseCourseTime;
@property (weak, nonatomic) IBOutlet UILabel *courseStart;
@property (weak, nonatomic) IBOutlet UILabel *courseCategory;

@property (weak, nonatomic) IBOutlet UILabel *courseProperty;

@property (weak, nonatomic) IBOutlet UILabel *classroomForm;
@property (weak, nonatomic) IBOutlet UILabel *examCategory;
@property (weak, nonatomic) IBOutlet UILabel *studyTime;
@property (weak, nonatomic) IBOutlet UILabel *peopleNum;
@property (weak, nonatomic) IBOutlet UILabel *creditLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;

@end
