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
    
    self.qTitleLabel.font = [UIFont fontWithName:kFontName size:13];
    self.qTitleLabel.textColor = [UIColor colorWithHexStr:@"141414"];
    
    self.locationLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.locationLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.timeLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.timeLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.viewsLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.viewsLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.replysLabel.font = [UIFont fontWithName:kFontName size:kTagFontFize];
    self.replysLabel.textColor = [UIColor colorWithHexStr:@"848484"];
    
    self.answerLabel.font = [UIFont fontWithName:kFontName size:14];
    self.answerLabel.textColor = [UIColor colorWithHexStr:@"737373"];
    
    self.userNameLabel.font = [UIFont fontWithName:kFontName size:18];
    self.userNameLabel.textColor = [UIColor blackColor];
    
    self.likeBtn.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.userAvatarBtn.layer.cornerRadius = 15;
    self.userAvatarBtn.layer.masksToBounds = YES;
    self.userAvatarBtn.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
