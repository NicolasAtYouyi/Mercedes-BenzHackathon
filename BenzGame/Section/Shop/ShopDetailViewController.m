//
//  ShopDetailViewController.m
//  BenzGame
//
//  Created by Nicolas on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController () <UIScrollViewDelegate> {
    NSInteger imageNum;
}

@property (strong, nonatomic) UIScrollView *baseScrollview;
@property (strong, nonatomic) UIScrollView *topScrollview;
@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imageNum = 4;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, CGRectGetHeight(self.topScrollview.frame))];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i + 1]];
        [self.topScrollview addSubview:imageView];
    }
    
    self.topScrollview.contentSize = CGSizeMake(ScreenWidth * imageNum, CGRectGetHeight(self.topScrollview.frame));
    self.topScrollview.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.topScrollview) {
        
        int index = round((float)scrollView.contentOffset.x / (float)ScreenWidth);
        self.pageControl.currentPage = index;
    }
}



- (UIScrollView *)baseScrollview {
    if (_baseScrollview == nil) {
        self.baseScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50)];
        [self.view addSubview:_baseScrollview];
    }
    return _baseScrollview;
}

- (UIScrollView *)topScrollview {
    if (_topScrollview == nil) {
        self.topScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 816 / 2.)];
        _topScrollview.delegate = self;
        [self.baseScrollview addSubview:_topScrollview];
    }
    return _topScrollview;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth - 120, CGRectGetHeight(self.topScrollview.frame) - 20, 100, 10)];
        _pageControl.numberOfPages = imageNum;
        _pageControl.pageIndicatorTintColor = [WhiteColor colorWithAlphaComponent:.5];
        _pageControl.currentPageIndicatorTintColor = WhiteColor;
        [self.topScrollview addSubview:_pageControl];
    }
    return _pageControl;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
