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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
