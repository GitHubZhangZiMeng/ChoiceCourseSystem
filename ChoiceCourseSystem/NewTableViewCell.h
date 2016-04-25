//
//  NewTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/25.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *collegeName;
@property (weak, nonatomic) IBOutlet UILabel *fristLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UILabel *trirdLab;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;

@end
