//
//  BGQuestionDetailViewController.h
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGQuestionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonnull) NSDictionary *questionDic;

@end
