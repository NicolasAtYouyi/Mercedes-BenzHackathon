//
//  BGShopListViewController.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGShopListViewController.h"
#import "BGConstant.h"
#import "BGShopListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface BGShopListViewController ()<UITableViewDataSource, UITableViewDelegate, BGShopListCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *wishListBtn;

@property (strong, nonnull) UIImageView *wishListAnimationImgView;
@end

@implementation BGShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)initTabBar{
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商城" image:[UIImage imageNamed:@"icon_store"] selectedImage:[UIImage imageNamed:@"icon_store_checked"]];
    //    tabBarItem = UITabBarItem.init(title: "画报", image: UIImage.init(named: "bottombar_magazine_unselected"), tag: 0)
    //    tabBarItem.selectedImage = UIImage.init(named: "bottombar_magazine_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    //    tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -4)
}


#pragma mark -setup subview
- (void)setupTableView {
    
    self.titleView.backgroundColor = [UIColor colorWithHexStr:kMainBkgColorStr];
    self.titleLabel.text = @"ME商城";
    self.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    
    self.tableView.backgroundColor = [UIColor colorWithHexStr:@"efefef"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BGShopListCell" bundle:nil] forCellReuseIdentifier:@"BGShopListCell"];
}

#pragma mark -UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGShopListCell" forIndexPath:indexPath];
    [self configCell:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0.0;
    cellHeight = [tableView fd_heightForCellWithIdentifier:@"BGShopListCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:(BGShopListCell *)cell indexPath:indexPath];
    }];

    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BGShopListCell *detail = [[BGQuestionDetailViewController alloc] initWithNibName:@"BGQuestionDetailViewController" bundle:nil];
//    detail.transitioningDelegate = self;
//    detail.questionDic = self.questionsArr[indexPath.row];
//    
//    //    [self parentViewController]
//    //    [self.navigationController pushViewController:detail animated:YES];
//    [self.parentViewController presentViewController:detail animated:true completion:^{
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    }];
}
- (void)configCell:(BGShopListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = [BGDataUtil sharedInstance].shopListArr;
    NSDictionary *shopDic = arr[indexPath.row % arr.count];
    
    cell.tag = indexPath.row;
    cell.delegate = self;
    [cell.imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shop_%ld.jpeg", indexPath.row % 3 + 1]]];
    cell.nameLabel.text = shopDic[@"name"];
    cell.priceLabel.text = shopDic[@"price"];
    
    NSInteger country = [shopDic[@"country"] integerValue];
    if (country == 1) {
        cell.tagLabel.image = [UIImage imageNamed:@"icon_Germany"];
    } else {
        cell.tagLabel.image = [UIImage imageNamed:@"icon_China"];
    }
}

#pragma mark -BGShopListCellDelegate
- (void)onShopListCellDidLike:(NSUInteger)index hasLike:(BOOL)hasLike {
    if (hasLike) {
        return;
    }
    BGShopListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGPoint center = [cell convertPoint:cell.imgView.center toView:self.view];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 80.0)];
    img.center = center;
    img.backgroundColor = [UIColor redColor];
    img.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.wishListAnimationImgView = img;
    [self.view addSubview:img];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addQuadCurveToPoint:self.wishListBtn.center controlPoint:CGPointMake(center.x + 40, center.y - 50)];
    
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        img.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position";
        animation.duration = 0.4;
        animation.path = path.CGPath;
        animation.delegate = self;
        [img.layer addAnimation:animation forKey:nil];
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            img.transform = CGAffineTransformMakeScale(0.2, 0.2);
        } completion:^(BOOL finished) {
            [img removeFromSuperview];
        }];
        
    }];
    
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        img.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    } completion:^(BOOL finished) {
//        [img.layer addAnimation:animation forKey:nil];
//    }];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.wishListAnimationImgView removeFromSuperview];
}

@end
