//
//  CourseInfoTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/11.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *collegeName;
@property (weak, nonatomic) IBOutlet UILabel *maiorName;
@property (weak, nonatomic) IBOutlet UILabel *openTime;
@property (weak, nonatomic) IBOutlet UILabel *gradeyear;
@property (weak, nonatomic) IBOutlet UILabel *totalhour;
@property (weak, nonatomic) IBOutlet UILabel *courseClass;



@end
