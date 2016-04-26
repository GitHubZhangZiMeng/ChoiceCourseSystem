//
//  NewTableViewCell.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/25.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell

//cell1
@property (weak, nonatomic) IBOutlet UILabel *timeLab1;
@property (weak, nonatomic) IBOutlet UILabel *collegeName1;
@property (weak, nonatomic) IBOutlet UILabel *fristLab1;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn1;



//cell2
@property (weak, nonatomic) IBOutlet UILabel *timeLab2;
@property (weak, nonatomic) IBOutlet UILabel *collegeName2;
@property (weak, nonatomic) IBOutlet UILabel *fristLab2;
@property (weak, nonatomic) IBOutlet UILabel *secondLab2;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn2;


//cell3

@property (weak, nonatomic) IBOutlet UILabel *timeLab3;
@property (weak, nonatomic) IBOutlet UILabel *collegeName3;
@property (weak, nonatomic) IBOutlet UILabel *fristLab3;
@property (weak, nonatomic) IBOutlet UILabel *secondLab3;
@property (weak, nonatomic) IBOutlet UILabel *trirdLab3;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn3;
@end
