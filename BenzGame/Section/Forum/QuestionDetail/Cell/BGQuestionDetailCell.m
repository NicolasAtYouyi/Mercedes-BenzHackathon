//
//  BGQuestionDetailCell.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionDetailCell.h"
#import "BGConstant.h"

@implementation BGQuestionDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sepratorView.backgroundColor = [UIColor colorWithHexStr:kSepratorColorStr];
    
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont fontWithName:kFontName size:kAnswerContentFontFize];
    self.contentLabel.textColor = [UIColor colorWithHexStr:kAnswerContentColor];
    
    self.nameLabel.font = [UIFont fontWithName:kFontName size:kUserNameFontFize];
    self.nameLabel.textColor = [UIColor blackColor];
    
    self.likeBtn.titleLabel.font = [UIFont fontWithName:kFontName size:kAnswerLikeFontFize];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.commentBtn.titleLabel.font = [UIFont fontWithName:kFontName size:kAnswerLikeFontFize];
    [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.avatarBtn.layer.cornerRadius = 15;
    self.avatarBtn.layer.masksToBounds = YES;
    self.avatarBtn.backgroundColor = [UIColor redColor];

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
