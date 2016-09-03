//
//  BGQuestionDetailHeaderCell.h
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGQuestionDetailHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *qTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImgV;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;

@end
