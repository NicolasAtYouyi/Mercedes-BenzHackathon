//
//  BGQuestionDetailHeaderCell.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionDetailHeaderCell.h"
#import "BGConstant.h"

@implementation BGQuestionDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sepratorView.backgroundColor = [UIColor colorWithHexStr:kSepratorColorStr];
    
    self.qTitleLabel.numberOfLines = 0;
    
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
