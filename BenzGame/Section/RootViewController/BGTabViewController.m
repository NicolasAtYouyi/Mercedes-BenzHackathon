//
//  BGTabViewController.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGTabViewController.h"
#import "BGForumViewController.h"
#import "UIColor+HexColor.h"
#import "BGQuestionListViewController.h"
#import "BGConstant.h"

@interface BGTabViewController ()

@end

@implementation BGTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden {
    return  false;
}

#pragma mark - private
- (void) setupViewControllers{
    BGForumViewController * forum = [[BGForumViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [forum initTabBar];
    forum.segmentedControlRect = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 64.0);
    forum.headerBackgroundColor = [UIColor colorWithHexStr:kMainBkgColorStr];
    
    
    BGQuestionListViewController * list = [[BGQuestionListViewController alloc] initWithNibName:@"BGQuestionListViewController" bundle:nil];
    BGQuestionListViewController * list2 = [[BGQuestionListViewController alloc] initWithNibName:@"BGQuestionListViewController" bundle:nil];
    
    
    NSMutableArray *arrMenuItems = @[@"推荐",@"全部"];
    NSMutableArray *vcs = @[list, list2];
    
    forum.arrMenuItems = arrMenuItems;
    forum.viewControllerArray = vcs;
    
    self.viewControllers = @[forum];
}

@end
