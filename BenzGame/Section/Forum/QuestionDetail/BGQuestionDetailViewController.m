//
//  BGQuestionDetailViewController.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionDetailViewController.h"
#import "BGConstant.h"
#import "BGQuestionTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BGQuestionDetailHeaderCell.h"
#import "BGQuestionDetailCell.h"
#import "BenzGame-Swift.h"

static NSString *const kCell = @"BGQuestionDetailCell";
static NSString *const kHeaderCell = @"BGQuestionDetailHeaderCell";

@interface BGQuestionDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *answersArr;
@property (assign, nonatomic) int itemsCount;
@property (strong, nonatomic) ZUITranslucenceLayerModalTransition *modelTransition;

@end

@implementation BGQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubview];
    
    self.answersArr = self.questionDic[kAnswersArr];
    self.itemsCount = 1;
    if (self.answersArr.count > 0) {
        self.itemsCount += self.answersArr.count;
    }
    
    self.modelTransition = [[ZUITranslucenceLayerModalTransition alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -Subview
- (void)setupSubview{
    
    self.titleView.backgroundColor = [UIColor colorWithHexStr:kMainBkgColorStr];
    self.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.tableView.backgroundColor = [UIColor colorWithHexStr:@"efefef"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:kCell bundle:nil] forCellReuseIdentifier:kCell];
    [self.tableView registerNib:[UINib nibWithNibName:kHeaderCell bundle:nil] forCellReuseIdentifier:kHeaderCell];
}

#pragma mark -Button Action

- (IBAction)shareBtnAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ZUIShare" bundle:nil];
    ZUIShareViewController *shareVC = [storyboard instantiateViewControllerWithIdentifier:@"ZUIShareViewController"];
    shareVC.showCollection = false;
    shareVC.modalPresentationStyle = UIModalPresentationCustom;
    shareVC.transitioningDelegate = self.modelTransition;
    [self presentViewController:shareVC animated:true completion:nil];
    
//    let storyboard = UIStoryboard(name: "ZUIShare", bundle: nil)
//    let vc = storyboard.instantiateViewControllerWithIdentifier("ZUIShareViewController") as! ZUIShareViewController
//    shareVC = vc
//    vc.delegate = self
//    vc.isMarked = ZUIUser.sharedInstance.collectedIdsArr.contains(pictorial!.id)
//    
//    vc.transitioningDelegate = modelTransition
//    vc.modalPresentationStyle = .Custom
//    presentViewController(vc, animated: true, completion: nil)

}
- (IBAction)collectBtnAction:(id)sender {
    if (self.collectBtn.isSelected) {
        [self.collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    } else {
        [self.collectBtn setImage:[UIImage imageNamed:@"collect_selected"] forState:UIControlStateNormal];
    }
    [self.collectBtn setSelected:!self.collectBtn.selected];
}
- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark -UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCell forIndexPath:indexPath];
        [self configHeaderCell:(BGQuestionDetailHeaderCell *)cell indexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
        [self configCell:(BGQuestionDetailCell *)cell indexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0.0;
    if (indexPath.row < self.itemsCount) {
        if (indexPath.row == 0) {
            cellHeight = [tableView fd_heightForCellWithIdentifier:kHeaderCell cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configHeaderCell:(BGQuestionDetailHeaderCell *)cell indexPath:indexPath];
            }];
        } else {
            cellHeight = [tableView fd_heightForCellWithIdentifier:kCell cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configCell:(BGQuestionDetailCell *)cell indexPath:indexPath];
            }];
        }
    }
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BGQuestionDetailViewController *detail = [[BGQuestionDetailViewController alloc] initWithNibName:@"BGQuestionDetailViewController" bundle:nil];
//    detail.transitioningDelegate = self;
//    
//    //    [self parentViewController]
//    //    [self.navigationController pushViewController:detail animated:YES];
//    [self.parentViewController presentViewController:detail animated:true completion:^{
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    }];
}
- (void)configCell:(BGQuestionDetailCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.itemsCount) {
        return;
    }
    
    NSDictionary *dic = self.answersArr[indexPath.row - 1];
    
    cell.contentLabel.text = dic[kContent];
    [cell.likeBtn setTitle:[NSString stringWithFormat:@" %@", dic[kLikeNum]] forState:UIControlStateNormal];
    
    [cell.commentBtn setTitle:[NSString stringWithFormat:@" %@", dic[kLikeNum]] forState:UIControlStateNormal];
    
    NSArray *userArr = [BGDataUtil sharedInstance].usersArr;
    NSDictionary *userDic = userArr[indexPath.row % userArr.count];
    cell.nameLabel.text = userDic[kUsreName];
    [cell.avatarBtn setImage:[UIImage imageNamed:userDic[kUsreAvatar]] forState:UIControlStateNormal];
    
}

- (void)configHeaderCell:(BGQuestionDetailHeaderCell *)cell indexPath:(NSIndexPath *)indexPath {
        if (indexPath.row >= self.itemsCount) {
            return;
        }
        cell.qTitleLabel.text = self.questionDic[kTItle];
        cell.locationLabel.text = self.questionDic[kLocation];
        cell.timeLabel.text = self.questionDic[kTime];
        cell.replysLabel.text = self.questionDic[kAnswersCount];
        cell.viewsLabel.text = [NSString stringWithFormat:@"%d",[self.questionDic[kAnswersCount] integerValue] + 20];
}


@end
