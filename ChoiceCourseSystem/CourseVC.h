//
//  CourseVC.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/19.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "SuperViewController.h"

@interface CourseVC : SuperViewController


@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *teacher;

@property (nonatomic, strong)NSString *collegeStr;
@property (nonatomic, strong)NSString *course;
@property (nonatomic, strong)NSString *teach;
@property (nonatomic, strong)NSString *openTime;
@property (nonatomic, strong)NSString *major;
@property (nonatomic, strong)NSString *clas;
@property (nonatomic, strong)NSString *totalhour;



@end
