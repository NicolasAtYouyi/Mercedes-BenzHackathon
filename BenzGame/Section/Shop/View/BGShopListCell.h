//
//  BGShopListCell.h
//  BenzGame
//
//  Created by wangyangyang on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGShopListCellDelegate <NSObject>

- (void)onShopListCellDidLike:(NSUInteger) index hasLike:(BOOL) hasLike;

@end

@interface BGShopListCell : UITableViewCell

@property (assign, nonatomic) id<BGShopListCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;

@end
