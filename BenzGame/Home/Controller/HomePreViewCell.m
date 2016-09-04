//
//  HomePreViewCell.m
//  YouYi
//
//  Created by Nicolas on 16/4/9.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "HomePreViewCell.h"
#import "BGConstant.h"

@interface HomePreViewCell ()

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@end


@implementation HomePreViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.smallLabel.text = @"强劲本质";
    self.smallLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    self.smallLabel.font = [UIFont fontWithName:kFontName size:16.];
    self.addressLabel.text  = @" 中国北京";
    self.addressLabel.textColor = WhiteColor;
    self.addressLabel.font = [UIFont fontWithName:kFontName size:11.];
    self.dateLabel.text = @"2016.05.03";
    self.dateLabel.textColor = WhiteColor;
    self.dateLabel.font = [UIFont fontWithName:kFontName size:11.];
    self.contentLabel.text = @"和故事空格键开关可看过就阿里过奖了十几个垃圾啊老规矩";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont fontWithName:kFontName size:13.];
    self.contentLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    
    self.timeLabel.hidden = YES;
    self.line.hidden = YES;
    self.grayView.hidden = YES;
    
    
    self.backgroundColor = ClearColor;
    
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bigImageView.clipsToBounds = YES;
    self.bigImageView.layer.cornerRadius = 4 / 2;
    /*self.bigImageView.layer.borderColor = MainLineColor.CGColor;
    self.bigImageView.layer.borderWidth = 1. / 2;*/
    
    self.baseView.backgroundColor = WhiteColor;
    self.baseView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    self.baseView.layer.shadowOpacity = .4;
    self.baseView.layer.shadowOffset = CGSizeMake(3 / 2., 3 / 2.);
    self.baseView.layer.shadowRadius = 6 / 2.;
    
//    self.baseView.layer.borderColor = MainLineColor.CGColor;
//    self.baseView.layer.borderWidth = 1 / 2.;
    
    self.timeLabel.backgroundColor = MainBGColor;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont fontWithName:Georgia size:SmallSize];
    self.timeLabel.text = @"March 3rd, 2016";
    self.timeLabel.textColor = WhiteColor;
    
//    self.grayView.backgroundColor = [UIColor colorWithRed:164 / 255. green:55 / 255. blue:48 / 255. alpha:1.];
//    self.grayView.transform = CGAffineTransformMakeRotation(-M_PI / 4);
    self.grayView.layer.contents = (id)[UIImage imageNamed:@"time-shadow"].CGImage;
    self.grayView.backgroundColor = ClearColor;
    
//    self.line.backgroundColor = [UIColor colorWithRed:164 / 255. green:55 / 255. blue:48 / 255. alpha:1.];
    self.line.backgroundColor = ClearColor;
}

- (void)showCellData:(NSDictionary *)item {
    
//    [self.bigImageView sd_setImageWithURL:[YouyiImageManager appHomeLookbookURL:item.imageUrl] placeholderImage:[UIImage imageNamed:@"img-placeholder"]];
    
    self.bigImageView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", item[@"image"]]];
}

- (void)showData:(NSDictionary *)item{
    
//    [self.bigImageView sd_setImageWithURL:[YouyiImageManager appHomeLookbookURL:home.imageUrl] placeholderImage:[UIImage imageNamed:@"img-placeholder"]];
    self.timeLabel.text = @"test";
    self.bigImageView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", item[@"image"]]];
    self.smallLabel.text = item[@"title"];
    self.contentLabel.text = item[@"content"];

}


@end

