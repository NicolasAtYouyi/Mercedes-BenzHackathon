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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
