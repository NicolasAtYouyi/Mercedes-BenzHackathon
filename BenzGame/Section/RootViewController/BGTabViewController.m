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
#import "BGShopListViewController.h"

@interface BGTabViewController ()

@end

@implementation BGTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
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

- (void)setupTabBar{
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor colorWithHexStr:@"bababa"], NSFontAttributeName:[UIFont fontWithName:kFontName size:10]};
     NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor colorWithHexStr:@"474848"], NSFontAttributeName:[UIFont fontWithName:kFontName size:10]};
    [[UITabBarItem appearance] setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    self.tabBar.translucent = NO;
//    self.tabBar.backgroundColor = [UIColor colorWithHexStr:@"010101"];
    self.tabBar.barTintColor = [UIColor colorWithHexStr:@"010101"];
    self.tabBar.tintColor = [UIColor whiteColor];
    
//    let normalDic: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.init(hexStr: "bababa"), NSFontAttributeName: UIFont.init(name: ZUIFontLanTingHeiThin, size: 10)!]
//    let selectedDic = [NSForegroundColorAttributeName: UIColor.init(hexStr: "474848"), NSFontAttributeName: UIFont.init(name: ZUIFontLanTingHeiThin, size: 10)!]
//    UITabBarItem.appearance().setTitleTextAttributes(normalDic, forState: UIControlState.Normal)
//    UITabBarItem.appearance().setTitleTextAttributes(selectedDic, forState: UIControlState.Selected)
//    tabBar.translucent = false
//    tabBar.tintColor = UIColor.whiteColor()

}

- (void) setupViewControllers{
    
    
    BGShopListViewController *shopList = [[BGShopListViewController alloc] initWithNibName:@"BGShopListViewController" bundle:nil];
    [shopList initTabBar];
    
    
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
    
    self.viewControllers = @[shopList,forum];
}

@end
