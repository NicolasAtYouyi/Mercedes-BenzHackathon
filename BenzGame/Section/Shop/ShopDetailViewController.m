//
//  ShopDetailViewController.m
//  BenzGame
//
//  Created by Nicolas on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "LookCarViewController.h"

@interface ShopDetailViewController () <UIScrollViewDelegate> {
    NSInteger imageNum;
}

@property (strong, nonatomic) UIScrollView *baseScrollview;
@property (strong, nonatomic) UIScrollView *topScrollview;
@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation ShopDetailViewController

static NSString * const kFontName = @"PingFang SC";

- (BOOL)prefersStatusBarHidden {
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    
    imageNum = 4;
    self.topScrollview.contentSize = CGSizeMake(ScreenWidth * imageNum, CGRectGetHeight(self.topScrollview.frame));
    self.topScrollview.pagingEnabled = YES;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, CGRectGetHeight(self.topScrollview.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i + 1]];
        [self.topScrollview addSubview:imageView];
    }
    
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 20, 50, 50);
    [backButton setImage:[UIImage imageNamed:@"icon_back_normal"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2. - 50, 20, 100, 44)];
    titleLabel.text = @"车辆详情";
    titleLabel.textAlignment  = NSTextAlignmentCenter;
    titleLabel.textColor = WhiteColor;
    [self.view addSubview:titleLabel];
    
    UIButton *shareButton =  [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareButton.frame = CGRectMake(ScreenWidth - 50, 20, 50, 50);
    [shareButton setImage:[UIImage imageNamed:@"icon_share"] forState:(UIControlStateNormal)];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareButton];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13 + CGRectGetMaxY(self.topScrollview.frame), ScreenWidth - 30, 20)];
    nameLabel.font = [UIFont fontWithName:kFontName size:14];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"G-Klasse,G500";
    [self.baseScrollview addSubview:nameLabel];
    
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 6 + CGRectGetMaxY(nameLabel.frame), 100, 20)];
    priceLabel.font = [UIFont fontWithName:kFontName size:12];
    priceLabel.text = @"¥2,318,000";
    priceLabel.textColor = [self colorWithHexStr:@"717171"];
    [self.baseScrollview addSubview:priceLabel];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), CGRectGetMinY(priceLabel.frame), 20, CGRectGetHeight(priceLabel.frame))];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"icon_China"];
    [self.baseScrollview addSubview:imageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.topScrollview.frame) + 70, ScreenWidth - 30, .5)];
    line.backgroundColor = lineBGColor;
    [self.baseScrollview addSubview:line];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat width = (ScreenWidth - 20 * 2) / 3.;
        payButton.frame = CGRectMake(20 + width * i, CGRectGetMaxY(line.frame), width, 111);
        [payButton setImage:[UIImage imageNamed:@"icon_financial"] forState:(UIControlStateNormal)];
        if (i == 1) {
            [payButton setImage:[UIImage imageNamed:@"icon_ Parameter"] forState:(UIControlStateNormal)];
        }
        if (i == 2) {
            [payButton setImage:[UIImage imageNamed:@"icon_about"] forState:(UIControlStateNormal)];
        }
        [payButton setImageEdgeInsets:(UIEdgeInsetsMake(-30, 0, 0, 0))];
        UILabel *bomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, CGRectGetWidth(payButton.frame), 20)];
        bomLabel.textAlignment = NSTextAlignmentCenter;
        bomLabel.text = @"金融方案";
        if (i == 1) {
            bomLabel.text = @"相关参数";
        }
        if (i == 2) {
            bomLabel.text = @"相关问答";
        }
        [payButton addSubview:bomLabel];
        
        [payButton addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 1) {
            [payButton addTarget:self action:@selector(getTheData) forControlEvents:(UIControlEventTouchUpInside)];
        }
        if (i == 2) {
            [payButton addTarget:self action:@selector(questionAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        [self.baseScrollview addSubview:payButton];
    }
    
    UIButton *payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    payButton.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
    [payButton setImage:[UIImage imageNamed:@"icon_financial"] forState:(UIControlStateNormal)];
    payButton.backgroundColor = [UIColor blackColor];
    [payButton setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [payButton setTitle:@"预约看车" forState:(UIControlStateNormal)];
    [payButton addTarget:self action:@selector(attation) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:payButton];
}

- (void)attation {
    NSLog(@"预约");
//    LookCarViewController *lookCarVC = [[LookCarViewController alloc] init];
//    [self.navigationController showViewController:lookCarVC sender:nil];
}

- (void)payAction {
    NSLog(@"pay");
}

- (void)getTheData {
    NSLog(@"获取参数");
}

- (void)questionAction {
    NSLog(@"question");
}

- (void)shareAction {
    NSLog(@"share");
}

- (UIColor *)colorWithHexStr:(NSString *)hex
{
    return [self colorWithHexStr:hex alpha:1.f];
}

- (UIColor *)colorWithHexStr:(NSString *)hex alpha:(CGFloat)alpha
{
    if ([hex hasPrefix:@"0X"])
        hex = [hex substringFromIndex:2];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];
    
    if ([hex length]!=6 && [hex length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    int resultR = 0;
    NSString *strR = [hex substringWithRange:NSMakeRange(0, digits)];
    sscanf([strR UTF8String], "%x", &resultR);
    
    int resultG = 0;
    NSString *strG = [hex substringWithRange:NSMakeRange(digits, digits)];
    sscanf([strG UTF8String], "%x", &resultG);
    
    int resultB = 0;
    NSString *strB = [hex substringWithRange:NSMakeRange(2*digits, digits)];
    sscanf([strB UTF8String], "%x", &resultB);
    
    CGFloat red = resultR/maxValue;
    CGFloat green = resultG/maxValue;
    CGFloat blue = resultB/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
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
        _topScrollview.showsHorizontalScrollIndicator = NO;
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
        [self.baseScrollview addSubview:_pageControl];
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
