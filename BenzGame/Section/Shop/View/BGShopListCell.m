//
//  BGShopListCell.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGShopListCell.h"
#import "BGConstant.h"

@interface BGShopListCell()




@end

@implementation BGShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.sepratorView.backgroundColor = [UIColor colorWithHexStr:kSepratorColorStr];
//    self.qTitleLabel.numberOfLines = 0;
//    self.answerLabel.numberOfLines = 0;
//    
//    self.lineView.backgroundColor = [UIColor colorWithHexStr:kLineColorStr];
//    
    self.nameLabel.font = [UIFont fontWithName:kFontName size:14];
    self.nameLabel.textColor = [UIColor blackColor];
    
    self.priceLabel.font = [UIFont fontWithName:kFontName size:12];
    self.priceLabel.textColor = [UIColor colorWithHexStr:@"717171"];
    
    self.likeBtn.titleLabel.font = [UIFont fontWithName:kFontName size:13];
    [self.likeBtn setTitleColor:[UIColor colorWithHexStr:@"3a3a3a"] forState:UIControlStateNormal];
    self.likeBtn.layer.borderWidth = 1.0;
    self.likeBtn.layer.borderColor = [UIColor colorWithHexStr:@"3a3a3a"].CGColor;
    [self.likeBtn setTitle:@"加入心愿单" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)likeBtnAction:(id)sender {
    
    if (self.likeBtn.isSelected) {
        [self.likeBtn setTitle:@"加入心愿单" forState:UIControlStateNormal];
    } else {
        [self.likeBtn setTitle:@"已加入心愿单" forState:UIControlStateNormal];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(onShopListCellDidLike:hasLike:)]) {
        [self.delegate onShopListCellDidLike:self.tag hasLike:self.likeBtn.isSelected];
    }
    [self.likeBtn setSelected:!self.likeBtn.isSelected];
}

@end
