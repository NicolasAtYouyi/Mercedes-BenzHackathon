//
//  BGQuestionTableViewCell.h
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGQuestionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *qTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImgV;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *userAvatarBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *replysLabel;

@end
