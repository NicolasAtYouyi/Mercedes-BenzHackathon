//
//  BGForumViewController.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGForumViewController.h"

@interface BGForumViewController ()

@end

@implementation BGForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)initTabBar{
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
//    tabBarItem = UITabBarItem.init(title: "画报", image: UIImage.init(named: "bottombar_magazine_unselected"), tag: 0)
//    tabBarItem.selectedImage = UIImage.init(named: "bottombar_magazine_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//    tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -4)
}

@end
