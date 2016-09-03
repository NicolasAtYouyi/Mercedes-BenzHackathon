//
//  BaseController.m
//  YouYi
//
//  Created by Nicolas on 16/4/9.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "BaseController.h"
#import "HomePreViewController.h"
#import "HomePreViewFlowLayout.h"


@interface BaseController () <UIScrollViewDelegate> {
    HomePreViewController *homePreViewVC;
    UIScrollView *frontView;
    CGFloat firstOffsetX;
}

@property (nonatomic, strong) NSArray *dataArray;
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"homeBg"].CGImage;
    
    HomePreViewFlowLayout *homePreViewFL = [[HomePreViewFlowLayout alloc] init];
    homePreViewVC = [[HomePreViewController alloc] initWithCollectionViewLayout:homePreViewFL];
    
    [self addChildViewController:homePreViewVC];
    CGFloat height = 950 / 2.;//850 / 2.;
    if (iPhone6p) {
        height = 980 / 2.;
    }
    if (iPhone5) {
        height = 680 / 2.;
    }
    if (iPhone4) {
        height = 528 / 2.;
    }
    
    homePreViewVC.view.frame = CGRectMake(0, 80. + 40, ScreenWidth, height - 20);
    [self.view addSubview:homePreViewVC.view];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat width = CGRectGetWidth(homePreViewVC.view.frame) - itemWidthMargin / 2;
    CGFloat margin = (ScreenWidth - width) / 2;
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(homePreViewVC.view.frame), width, ScreenHeight - CGRectGetMaxY(homePreViewVC.view.frame) - TabHeight)];
    labelView.backgroundColor = ClearColor;
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 / 2, CGRectGetWidth(labelView.frame), 32 / 2)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont fontWithName:FontTypeFat size:BigSize];
//    titleLabel.textColor = MainFontColor;
//    titleLabel.text = @"有衣，每天千件衣服任意选！";
//    self.titleLabel = titleLabel;
    
//    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + CommonSize, CGRectGetWidth(labelView.frame), 68 / 2.)];
//    detailLabel.numberOfLines = 0;
//    detailLabel.attributedText = [self attributeStringWithString:@"清洗，消毒，熨烫全部交给我们来做"];
//    detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.detailLabel = detailLabel;
    
//    [labelView addSubview:titleLabel];
//    [labelView addSubview:detailLabel];
//    [self.view addSubview:labelView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changText:) name:@"changText" object:nil];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    pan.cancelsTouchesInView = YES;
    [homePreViewVC.collectionView addGestureRecognizer:pan];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    swipe.cancelsTouchesInView = YES;
    [homePreViewVC.collectionView addGestureRecognizer:swipe];

    //180 / 2. / 2                   - 180 / 2.
    frontView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80., CGRectGetWidth(homePreViewVC.view.frame), homePreViewVC.collectionView.frame.size.height + CGRectGetHeight(labelView.frame))];
    
    frontView.contentSize = CGSizeMake(frontView.frame.size.width, frontView.frame.size.height);
    frontView.backgroundColor = ClearColor;
    frontView.showsHorizontalScrollIndicator = NO;
    frontView.backgroundColor = ClearColor;
//    frontView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:.5];
    frontView.pagingEnabled = YES;
    frontView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction:)];
    [frontView addGestureRecognizer:tap];
    [self.view addSubview:frontView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(freshContentSize:) name:@"freshContentSize" object:nil];
    
//    UIButton *questionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    questionButton.frame = CGRectMake(18 / 2, CommonMargin + SmallMargin, CellHeight, CellHeight);
//    [questionButton addTarget:self action:@selector(questionAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [questionButton setTitle:@"\ue910" forState:(UIControlStateNormal)];
//    questionButton.titleLabel.font = [UIFont fontWithName:@"icomoon" size:IconFontSize];
//    [questionButton sizeToFit];
//    [questionButton setTitleColor:MainBGColor forState:(UIControlStateNormal)];
//    
//    [self.view addSubview:questionButton];
    
    
    
//    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.rightButton = rightButton;
//    [rightButton addTarget:self action:@selector(skipPage) forControlEvents:(UIControlEventTouchUpInside)];
//    rightButton.frame = CGRectMake(ScreenWidth - 18 / 2. - CellHeight, CommonMargin + SmallMargin, CellHeight, CellHeight);
//    //    rightButton.backgroundColor = [UIColor yellowColor];
//    rightButton.titleLabel.font = [UIFont fontWithName:@"icomoon" size:IconFontSize];
////    [rightButton sizeToFit];
//    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
//    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightButton setTitleColor:MainBGColor forState:(UIControlStateNormal)];
//    [self.view addSubview:rightButton];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qa_location"]];
    imageView.frame = CGRectMake(ScreenWidth / 2. - 60 / 2., 25, 10, 15);
    [topView addSubview:imageView];
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2. - 30 / 2., 20, 40, 25)];
    addLabel.textAlignment = NSTextAlignmentCenter;
    addLabel.text = @"北京";
    [topView addSubview:addLabel];
    
    [self.view addSubview:topView];
}

- (void)freshContentSize:(NSNotification *)notification {
    
    NSArray *dataArray = notification.object;
    self.dataArray = dataArray;
    NSInteger count = dataArray.count;
    frontView.contentSize = CGSizeMake(frontView.frame.size.width * count, frontView.frame.size.height);
}

- (void)scrollViewTapAction:(UITapGestureRecognizer *)tap {
    
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / ScreenWidth);
    
//    NSLog(@"%lf, %ld", scrollView.contentOffset.x, index);
    
    [homePreViewVC collectionView:homePreViewVC.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
//    NSLog(@"%@", pan);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static BOOL isFirst = YES;
    if (isFirst == YES) {
        firstOffsetX = homePreViewVC.collectionView.contentOffset.x;
        isFirst = NO;
    }
    
    if (scrollView == frontView) {
        
        CGFloat x = 0;
        x = firstOffsetX + (frontView.contentOffset.x) * (ScreenWidth - itemWidthMargin / 2.) / ScreenWidth;
        
        CGPoint offset = CGPointMake(x, homePreViewVC.collectionView.contentOffset.y);
        homePreViewVC.collectionView.contentOffset = offset;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)changText:(NSNotification *)notification {
    
    NSInteger index = [notification.object[@"index"] integerValue];
    
    NSDictionary *home = self.dataArray[index];
//    self.titleLabel.attributedText = ;
//    self.detailLabel.attributedText = [self attributeStringWithString:home.describe];
}

- (NSAttributedString *)attributeStringWithString:(NSString *)str {
    
    NSString *detailString = str ? str : @"";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:detailString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailString.length)];
    [string addAttribute:NSForegroundColorAttributeName value:SubBigFontColor range:NSMakeRange(0, detailString.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:FontTypeFat size:SmallSize] range:NSMakeRange(0, detailString.length)];
    
    return string;
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
