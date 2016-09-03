//
//  ZUISwipePageViewController.h
//  ZUIMaker
//
//  Created by lz on 15/1/16.
//  Copyright (c) 2015年 zuimeia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKSwipeBetweenViewControllers.h"

@protocol ZUISwipePageViewControllerDelegate;

@interface ZUISwipePageViewController : RKSwipeBetweenViewControllers

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, readonly) UIView *headerView;
@property (nonatomic, strong) UIColor *headerBackgroundColor;
@property (nonatomic, strong) NSMutableArray *arrMenuItems;
//@property (nonatomic, strong) NSString *titleStr;
//@property (nonatomic, strong) UIFont *titleFont;
//@property (nonatomic, assign) BOOL hasTitle;

@property (nonatomic, assign) CGRect segmentedControlRect;
//@property (nonatomic, strong) UIFont *nFont;
//@property (nonatomic, strong) UIFont *sFont;

@property (nonatomic, weak) id<ZUISwipePageViewControllerDelegate> swipePageVCDelegate;


@property (nonatomic, strong) UIImageView *ivBlurBackground;

- (void)setTitleLabelHighlight:(NSInteger)index withAnimation:(BOOL)isAnimation;

- (void)setupTitleLabels;

@end



@protocol ZUISwipePageViewControllerDelegate <NSObject>

- (void)changePageFinish:(NSInteger)index;
- (void)changePageWithIndex:(NSInteger)index withRate:(CGFloat)rate;
- (void)onTapTitleAtIndex:(NSInteger)index;

@end