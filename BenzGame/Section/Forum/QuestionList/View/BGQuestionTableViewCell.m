//
//  BGQuestionTableViewCell.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionTableViewCell.h"
#import "UIColor+HexColor.h"
#import "BGConstant.h"


@interface BGQuestionTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;

@end


@implementation BGQuestionTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sepratorView.backgroundColor = [UIColor colorWithHexStr:kSepratorColorStr];
    self.qTitleLabel.numberOfLines = 0;
    self.answerLabel.numberOfLines = 0;
    
    self.lineView.backgroundColor = [UIColor colorWithHexStr:kLineColorStr];
    
    self.qTitleLabel.font = [UIFont fontWithName:kFontName size:kQuestionTitleFontFize];
    self.qTitleLabel.textColor = [UIColor colorWithHexStr:kQuestionTitleColor];
    
    self.locationLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.locationLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.timeLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.timeLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.viewsLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.viewsLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.replysLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.replysLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.answerLabel.font = [UIFont fontWithName:kFontName size:kAnswerContentFontFize];
    self.answerLabel.textColor = [UIColor colorWithHexStr:kAnswerContentColor];
    
    self.userNameLabel.font = [UIFont fontWithName:kFontName size:kUserNameFontFize];
    self.userNameLabel.textColor = [UIColor blackColor];
    
    self.likeBtn.titleLabel.font = [UIFont fontWithName:kFontName size:kAnswerLikeFontFize];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.userAvatarBtn.layer.cornerRadius = 15;
    self.userAvatarBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)likeBtnAction:(id)sender {
    NSString *countStr = [self.likeBtn titleForState:UIControlStateNormal];
    NSInteger count = 1;
    if (countStr.integerValue > 0) {
        count = countStr.integerValue;
    }
    if (self.likeBtn.isSelected) {
        [self.likeBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        count --;
    } else {
        [self.likeBtn setImage:[UIImage imageNamed:@"up_selected"] forState:UIControlStateNormal];
        count ++;
    }
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld", count] forState:UIControlStateNormal];
    [self.likeBtn setSelected:!self.likeBtn.isSelected];
}

@end
