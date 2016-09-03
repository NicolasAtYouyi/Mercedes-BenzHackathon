//
//  ZUISwipePageViewController.m
//  ZUIMaker
//
//  Created by lz on 15/1/16.
//  Copyright (c) 2015年 zuimeia. All rights reserved.
//

#import "ZUISwipePageViewController.h"
#import "CoreText/CoreText.h"

#define kTitleFont            [UIFont fontWithName:@"PingFang SC" size:13.0f] //[UIFont fontWithName:ZUIFontNameSelected size:([UIScreen mainScreen].bounds.size.height > 480)? 14.f:12.f]
#define kSelectedTitleFont    [UIFont fontWithName:@"PingFang SC" size:15.0f] //[UIFont fontWithName:ZUIFontNameSelected size:([UIScreen mainScreen].bounds.size.height > 480)? 21.f:18.f]

#define kSelectedTitleColor [UIColor whiteColor]
#define kNormalTitleColor [[UIColor whiteColor] colorWithAlphaComponent:0.35]
#define KNormalTitleColorAlpha 0.35f

@interface ZUISwipePageViewController(){
    CGFloat titleScrollViewStartX;
    CGPoint currentTitleScrollViewOffset;
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) NSMutableArray *titleLabelMArr;
@property (nonatomic, strong) NSMutableArray *titleLabelFrameMArr;
@property (nonatomic) BOOL isFirstLoadEnd;

@end

@implementation ZUISwipePageViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (!CGPointEqualToPoint(currentTitleScrollViewOffset, CGPointZero)) {
        [self.titleScrollView setContentOffset:currentTitleScrollViewOffset animated:NO];
    }
    
    [self.viewControllerArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (self.currentPageIndex == idx) {
            UIViewController *vc = (UIViewController *)obj;
            [vc viewWillAppear:animated];
        }
    }];
    
    
    if (self.currentPageIndex == 0 && !self.isFirstLoadEnd)  {
        [self pageChangeFinish:0];
    }
    self.isFirstLoadEnd = true;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.titleScrollView.contentOffset = currentTitleScrollViewOffset;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.titleScrollView.contentOffset = currentTitleScrollViewOffset;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    currentTitleScrollViewOffset = self.titleScrollView.contentOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstLoadEnd = false;
    self.view.backgroundColor = [UIColor clearColor];
    currentTitleScrollViewOffset = CGPointZero;
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

- (void)setupHeaderView {
    UIView *v = [[UIView alloc] init];
    v.frame = _segmentedControlRect;
    
    UIView *tagV = [[UIView alloc] init];
    tagV.frame = CGRectMake(0.0, 0.0, 20.0, 1.5);
    tagV.center = CGPointMake(_segmentedControlRect.size.width / 2, _segmentedControlRect.size.height - 6);
    tagV.backgroundColor = [UIColor whiteColor];
    [v addSubview:tagV];


    _headerView = v;
    if (_headerBackgroundColor != nil) {
        v.backgroundColor = _headerBackgroundColor;
    }
//    v.backgroundColor = [UIColor colorWithRed:40.f/255.f green:44.f/255.f blue:51.f/255.f alpha:1.f];

    [self.view addSubview:v];

//    if (_hasTitle && _titleStr) {
//        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 75.f, 19.f)];
//        _lbTitle = lbTitle;
//        lbTitle.textAlignment = NSTextAlignmentCenter;
//        [_headerView addSubview:lbTitle];
//        lbTitle.backgroundColor = [UIColor clearColor];
//
//        NSString *titleStr = _titleStr;//@"MAKE";
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:titleStr];
//        //设置字体及大小
//        CTFontRef helveticaBold = CTFontCreateWithName((__bridge CFStringRef)lbTitle.font.fontName,lbTitle.font.pointSize,NULL);
//        [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
//        
//        //设置字间距
//        long number = 1;
//        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//        [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[string length])];
//        CFRelease(num);
//        lbTitle.attributedText = string;
//        lbTitle.font = _titleFont;
//        lbTitle.center = CGPointMake(CGRectGetMidX(v.bounds), CGRectGetHeight(v.bounds)/4.f + 2.f);
//        lbTitle.textColor = [UIColor colorWithRed:105.f/255.f green:103.f/255.f blue:114.f/255.f alpha:1.f];
//    }
//    
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:_headerView.bounds];
//    iv.contentMode = UIViewContentModeScaleToFill;
//    iv.image = [UIImage imageNamed:@"shadow_titlemask"];
//    [_headerView insertSubview:iv atIndex:0];
}

- (void)setupTitleScrollView {
    
    CGRect svRect = CGRectMake(0, _segmentedControlRect.size.height - 44, _segmentedControlRect.size.width, 44);

    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:svRect];
    _titleScrollView = titleScrollView;
    titleScrollView.contentSize = CGSizeMake(svRect.size.width, svRect.size.height);
    titleScrollView.backgroundColor = [UIColor clearColor];

    [self.headerView addSubview:titleScrollView];
    
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, _segmentedControlRect.size.height)];
    leftImgView.image = [UIImage imageNamed:@"title_left_mask"];
    leftImgView.contentMode = UIViewContentModeScaleToFill;
    [self.headerView addSubview:leftImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_segmentedControlRect.size.width - 70, 0, 70, _segmentedControlRect.size.height)];
    rightImgView.image = [UIImage imageNamed:@"title_right_mask"];
    rightImgView.contentMode = UIViewContentModeScaleToFill;
    [self.headerView addSubview:rightImgView];

}

- (void)setupTitleLabels {
    if (!_titleLabelMArr) {
        _titleLabelMArr = [NSMutableArray array];
    }else {
        [_titleLabelMArr removeAllObjects];
//        if (_titleScrollView.subviews.count > 0) {
//            NSInteger count = _titleScrollView.subviews.count;
//            for (int i = 0; i < count;i ++) {
//                UIView *v = _titleScrollView.subviews[i];
//                [v removeFromSuperview];
//            }
//        }
    }

    __block CGRect lastCellRect = CGRectZero;
    __block NSDictionary *attrDic = @{NSFontAttributeName:kTitleFont};
    __block NSDictionary *selectedAttrDic = @{NSFontAttributeName:kSelectedTitleFont};

    if (!_titleLabelFrameMArr) {
        _titleLabelFrameMArr = [NSMutableArray array];
    }
    [self.arrMenuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *title = (NSString *) obj;
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(320, 0)
                                               options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                                                       NSStringDrawingUsesLineFragmentOrigin |
                                                       NSStringDrawingUsesFontLeading
                                            attributes:idx == self.currentPageIndex ? selectedAttrDic:attrDic
                                               context:nil].size;

        CGFloat x;
        CGFloat marginX;
        if (idx == self.currentPageIndex || idx == self.currentPageIndex + 1) {
            marginX = 20.f;
        } else {
            marginX = 15.f;
        }

        if (idx == 0) {
            x = 0.f;
        } else {
            x = lastCellRect.origin.x + lastCellRect.size.width + marginX;
        }
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(x, 0.0f, titleSize.width,_titleScrollView.bounds.size.height)];

        lb.tag = idx;
        lb.center = CGPointMake(lb.center.x, CGRectGetMidY(_titleScrollView.bounds));

        _titleLabelFrameMArr[idx] = NSStringFromCGRect(lb.frame);

        lb.textAlignment = NSTextAlignmentCenter;
        
        lb.text = title;
        
        lastCellRect = lb.frame;

        if (idx == self.currentPageIndex) {
            lb.textColor = [UIColor whiteColor];
            lb.font = kSelectedTitleFont;
        } else {
            lb.textColor = kNormalTitleColor;//[UIColor colorWithRed:150.f / 255.f green:151.f / 255.f blue:153.f / 255.f alpha:1.f];
            lb.font = kTitleFont;
        }

        lb.backgroundColor = [UIColor clearColor];
        [_titleScrollView addSubview:lb];
        [_titleLabelMArr addObject:lb];
        
        lb.tag = idx;
        lb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTitleTapGesture:)];
        [lb addGestureRecognizer:tap];
    }];

    UILabel *lastLabel = _titleLabelMArr.lastObject;
    [self.titleScrollView setContentOffset:CGPointMake(-(self.titleScrollView.frame.size.width - (lastLabel.frame.origin.x + lastLabel.frame.size.width))/ 2.f,0.f) animated:NO];

}

- (void)handleTitleTapGesture:(UITapGestureRecognizer *)gesture{
    UIView *v = gesture.view;
    
    if (self.swipePageVCDelegate && [self.swipePageVCDelegate respondsToSelector:@selector(onTapTitleAtIndex:)]) {
        [self.swipePageVCDelegate onTapTitleAtIndex:v.tag];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = v.tag;
    
    [self tapSegmentButtonAction:btn withAnimation:YES completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Util Methods

- (void)calculateTitleLabelFrame:(NSInteger)index {
    if (_titleLabelFrameMArr) {
        [_titleLabelFrameMArr removeAllObjects];
    } else {
        _titleLabelFrameMArr = [NSMutableArray array];
    }

    __block CGRect lastCellRect = CGRectZero;
    __block NSDictionary *attrDic = @{NSFontAttributeName:kTitleFont};
    __block NSDictionary *selectedAttrDic = @{NSFontAttributeName:kSelectedTitleFont};

    [_titleLabelMArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *lb = (UILabel *)obj;

        CGSize titleSize = [lb.text boundingRectWithSize:CGSizeMake(320, 0)
                                                 options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                                                         NSStringDrawingUsesLineFragmentOrigin |
                                                         NSStringDrawingUsesFontLeading
                                              attributes:idx == index ? selectedAttrDic:attrDic
                                                 context:nil].size;

        CGFloat x;
        CGFloat marginX;
        if (idx == index || idx == index + 1) {
            marginX = 20.f;
        } else {
            marginX = 15.f;
        }

        if (idx == 0) {
            x = 0.0f;
        } else {
            x = lastCellRect.origin.x + lastCellRect.size.width + marginX;
        }

        CGRect lbRect = lb.frame;
        lbRect.origin.x = x;
        
        lbRect.size.width = titleSize.width;
        lastCellRect = lbRect;

        [_titleLabelFrameMArr addObject:NSStringFromCGRect(lbRect)];
    }];
    
    NSLog(@"%@",_titleLabelFrameMArr);
}

- (void)setTitleLabelHighlight:(NSInteger)index withAnimation:(BOOL)isAnimation {
    UILabel *titleLabel = _titleLabelMArr[(NSUInteger) index];
    [self calculateTitleLabelFrame:index];

    [_titleLabelMArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *lb = (UILabel *)obj;

        NSString *rectStr = _titleLabelFrameMArr[idx];
        CGRect lbRect = CGRectFromString(rectStr);
        lb.frame = lbRect;
        lb.center = CGPointMake(lb.center.x, CGRectGetMidY(_titleScrollView.bounds));
        _titleLabelFrameMArr[idx] = NSStringFromCGRect(lb.frame);

        if (idx == index) {
            lb.textColor = kSelectedTitleColor;
            lb.font = kSelectedTitleFont;
        } else {
            lb.textColor = kNormalTitleColor;//[UIColor colorWithRed:150.f / 255.f green:151.f / 255.f blue:153.f / 255.f alpha:1.f];
            lb.font = kTitleFont;
        }
    }];
    [self.titleScrollView setContentOffset:CGPointMake(-((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(titleLabel.bounds) )/ 2.f - self.titleScrollView.frame.origin.x - titleLabel.frame.origin.x), 0) animated:isAnimation];
    currentTitleScrollViewOffset = self.titleScrollView.contentOffset;
}

- (void)setTitleHighlight:(NSInteger)index withRate:(CGFloat) xRate{
    NSInteger nextIndex = index;

    UILabel *currentLabel = _titleLabelMArr[(NSUInteger) self.currentPageIndex];
    UILabel *nextLabel = _titleLabelMArr[(NSUInteger) nextIndex];

    CGFloat nMarginX = 15.0f;
    CGFloat hMarginX = 20.0f;

    CGFloat colorNum = 255.0f;
    CGFloat color = (CGFloat)(255.0f - ceil((255.0f - colorNum) * xRate)) / 255.0f;
    CGFloat hColor = (CGFloat)((colorNum + ceil((255.0f - colorNum) * xRate)) / 255.0f);
    currentLabel.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1.f - (1.0f - KNormalTitleColorAlpha) * xRate];
    currentLabel.font = [UIFont fontWithName:kSelectedTitleFont.fontName size:kSelectedTitleFont.pointSize - (kSelectedTitleFont.pointSize - kTitleFont.pointSize) * xRate];

    CGSize cTitleSize = [currentLabel.text boundingRectWithSize:CGSizeMake(320, 0)
                                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                                                                NSStringDrawingUsesLineFragmentOrigin |
                                                                NSStringDrawingUsesFontLeading
                                                     attributes:@{NSFontAttributeName:[UIFont fontWithName:kSelectedTitleFont.fontName size:currentLabel.font.pointSize]}
                                                        context:nil].size;

    NSString *cRectStr = _titleLabelFrameMArr[(NSUInteger) self.currentPageIndex];
    CGRect cRect = CGRectFromString(cRectStr);
    CGFloat cCenterY = currentLabel.center.y;
    currentLabel.frame = CGRectMake(cRect.origin.x, cRect.origin.y, cTitleSize.width, cRect.size.height);
    currentLabel.center = CGPointMake(cRect.origin.x + cRect.size.width / 2.f, cCenterY);

    nextLabel.textColor = [UIColor colorWithRed:hColor green:hColor blue:hColor alpha:KNormalTitleColorAlpha + (1 - KNormalTitleColorAlpha) * xRate];
    nextLabel.font = [UIFont fontWithName:kTitleFont.fontName size:kTitleFont.pointSize + (kSelectedTitleFont.pointSize - kTitleFont.pointSize) * xRate];

    CGSize nTitleSize = [nextLabel.text boundingRectWithSize:CGSizeMake(320, 0)
                                                     options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                                                             NSStringDrawingUsesLineFragmentOrigin |
                                                             NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:kTitleFont.fontName size:nextLabel.font.pointSize]}
                                                     context:nil].size;

    NSString *nRectStr = _titleLabelFrameMArr[(NSUInteger) nextIndex];
    CGRect nRect = CGRectFromString(nRectStr);
    CGFloat centerY = nextLabel.center.y;
    nextLabel.frame = CGRectMake(nRect.origin.x, nRect.origin.y, nTitleSize.width, nRect.size.height);
    
    nextLabel.center = CGPointMake(nRect.origin.x + nRect.size.width / 2.f, centerY);

    CGRect lastCellRect = nextLabel.frame;
    for(NSInteger i = nextIndex - 1; i >= 0; i--) {
        UILabel *lb =  _titleLabelMArr[(NSUInteger) i];
        CGRect rect = lb.frame;

        if (i == nextIndex - 1) {
            if ([lb isEqual:currentLabel]) {
                CGFloat margin = lastCellRect.origin.x - currentLabel.frame.origin.x - currentLabel.frame.size.width;
                CGFloat homeOffsetX = 0.f;
                rect.origin.x = lastCellRect.origin.x - lb.frame.size.width - (margin + (homeOffsetX + hMarginX - margin) * xRate);
            } else {
                rect.origin.x = nextLabel.frame.origin.x - lb.frame.size.width - (nMarginX + (hMarginX - nMarginX) * xRate);
            }
        } else {
            UILabel *tlb = _titleLabelMArr[(NSUInteger) (i + 1)];
            if ([tlb isEqual:currentLabel]) {
                CGFloat homeOffsetX = 0.0f;
                rect.origin.x = lastCellRect.origin.x - (hMarginX - (hMarginX - nMarginX) * xRate) - lb.frame.size.width - homeOffsetX;
            } else {
                rect.origin.x = lastCellRect.origin.x - nMarginX - lb.frame.size.width;
            }
        }

        lb.frame = rect;
        lastCellRect = rect;
    }

    lastCellRect = nextLabel.frame;
    for(NSInteger i = nextIndex + 1; i < _titleLabelMArr.count; i++) {
        UILabel *lb =  _titleLabelMArr[(NSUInteger) i];
        CGRect rect = lb.frame;
        if (i == nextIndex + 1) {
            CGFloat margin = rect.origin.x - nextLabel.frame.origin.x - nextLabel.frame.size.width;
            rect.origin.x = lastCellRect.origin.x + lastCellRect.size.width + margin + (hMarginX - margin) * xRate;
        } else {
            if (i == self.currentPageIndex + 1) {
                rect.origin.x = lastCellRect.origin.x + lastCellRect.size.width + hMarginX - (hMarginX - nMarginX) * xRate;
            } else {
                rect.origin.x = lastCellRect.origin.x + lastCellRect.size.width + nMarginX;
            }
        }

        lb.frame = rect;
        lastCellRect = rect;
    }

    CGFloat nextTitleScrollViewContentOffsetX = -((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(nextLabel.bounds) )/ 2.f - self.titleScrollView.frame.origin.x - nextLabel.frame.origin.x);
    [self.titleScrollView setContentOffset:CGPointMake((CGFloat) (titleScrollViewStartX + ((nextIndex >= self.currentPageIndex)?1:-1) * (fabs(nextTitleScrollViewContentOffsetX - titleScrollViewStartX) * xRate)), 0) animated:NO];
    
    currentTitleScrollViewOffset = self.titleScrollView.contentOffset;
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    titleScrollViewStartX = self.titleScrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //remove pageViewController bounce
    if (self.currentPageIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    }
    if (self.currentPageIndex == [self.viewControllerArray count] - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    }

    CGFloat width = self.view.bounds.size.width;
    CGFloat xOffset = scrollView.contentOffset.x - width;
    CGFloat xRate = MIN(fabs(xOffset / width),1);

    NSInteger nextIndex;
    if (xOffset < 0) {
        nextIndex = self.currentPageIndex - 1;
    } else if(xOffset > 0) {
        nextIndex = self.currentPageIndex + 1;
    } else {
        nextIndex = self.currentPageIndex;
    }
    
    if (nextIndex > self.titleLabelMArr.count - 1 || nextIndex < 0) {
        return;
    }
    
    if (xRate == 0) {
        if (_swipePageVCDelegate && [_swipePageVCDelegate respondsToSelector:@selector(changePageWithIndex:withRate:)]) {
            [_swipePageVCDelegate changePageWithIndex:nextIndex withRate:xRate];
        }
        
        return;
    }
    [self setTitleHighlight:nextIndex withRate:xRate];
    
//    if (_swipePageVCDelegate && [_swipePageVCDelegate respondsToSelector:@selector(changePageWithIndex:withRate:)]) {
//        [_swipePageVCDelegate changePageWithIndex:nextIndex withRate:xRate];
//    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //remove pageViewController bounce
    if (self.currentPageIndex == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
        *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    }
    if (self.currentPageIndex == [self.viewControllerArray count]-1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
        *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setTitleLabelHighlight:self.currentPageIndex withAnimation:YES];
}

#pragma mark - Over Write Methods

- (void)setupSegmentButtons {
    if (_titleScrollView) {
        return;
    }
    [self setupHeaderView];
    [self setupTitleScrollView];
    [self setupTitleLabels];
}

- (void)pageChangeFinish:(NSUInteger)currentIndex{
    [self setTitleLabelHighlight:currentIndex withAnimation:NO];
    
    if (_swipePageVCDelegate && [_swipePageVCDelegate respondsToSelector:@selector(changePageFinish:)]) {
        [_swipePageVCDelegate changePageFinish:currentIndex];
    }

    titleScrollViewStartX = self.titleScrollView.contentOffset.x;
}
@end



