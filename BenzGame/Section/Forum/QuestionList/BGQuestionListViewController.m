//
//  BGQuestionListViewController.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionListViewController.h"
#import "BGQuestionTableViewCell.h"
#import "UIColor+HexColor.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BGQuestionDetailViewController.h"
#import "BGQuestionModelAnimation.h"
#import "BGConstant.h"



@interface BGQuestionListViewController ()<UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *dic;
@property (strong, nonatomic) NSMutableArray *questionsArr;


@property (strong, nonatomic) BGQuestionModelAnimation *animationDelegate;

@end

@implementation BGQuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationDelegate = [[BGQuestionModelAnimation alloc] init];
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
//    NSString *fileName = [path stringByAppendingPathComponent:@"Questions.plist"];
    
    self.questionsArr = [[NSMutableArray alloc] initWithContentsOfFile:fileName];
    
//    @{@"id":@1, @"name": @"名字1", @"avatar": @"avatar_1", @"level": @1, @"identity": @1};
    
    
//    NSDictionary *a = @{@"content":@"如果车处于行驶状态，此时先将车停好，关闭发动机等候10分钟左右，这是机油会全部回流至油底壳。此时，把机油尺拔出，先用干净的布把机油尺上原本的油迹擦去，再把机油尺插回至底部，过个几秒钟再次拔出机油尺即可测得准确的油面高度。在机油尺的末端有上限和下限的记号，观察被机油浸润的部分，如果在上下限之间，说明机油量正好，如果高于上限则说明机油量过多，低于下限则说明机油量过少，需要适量添加。", @"likeCount": @"4"};
//    
//    self.questionsArr = @[@{kTItle:@"奔驰S400怎么看机油多少?",kLocation:@"Beijing",kTime:@"1 hours ago",kViewsCount:@"5",kAnswersCount:@"4",kAnswersArr:@[a]}];
//    [self.questionsArr writeToFile:fileName atomically:true];
//    self.dic = @{@"title":@"I'm the test title"};
    
    
    [self setupTableView];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden {
    return  false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -setup subview
- (void)setupTableView {
    self.tableView.backgroundColor = [UIColor colorWithHexStr:@"efefef"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BGQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"QuestionCell"];
}


#pragma mark -UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
    [self configCell:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0.0;
    if (indexPath.row < 10) {
        cellHeight = [tableView fd_heightForCellWithIdentifier:@"QuestionCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configCell:(BGQuestionTableViewCell *)cell indexPath:indexPath];
        }];
    }
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BGQuestionDetailViewController *detail = [[BGQuestionDetailViewController alloc] initWithNibName:@"BGQuestionDetailViewController" bundle:nil];
    detail.transitioningDelegate = self;
    detail.questionDic = self.questionsArr[indexPath.row];
    
//    [self parentViewController]
//    [self.navigationController pushViewController:detail animated:YES];
    [self.parentViewController presentViewController:detail animated:true completion:^{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }];
}
- (void)configCell:(BGQuestionTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.questionsArr.count) {
        return;
    }
    
    NSDictionary *dic = self.questionsArr[indexPath.row];
    
    cell.qTitleLabel.text = dic[kTItle];
    cell.locationLabel.text = dic[kLocation];
    cell.timeLabel.text = dic[kTime];
    cell.replysLabel.text = dic[kAnswersCount];
    cell.viewsLabel.text = [NSString stringWithFormat:@"%d",[dic[kAnswersCount] integerValue] + 20];
    NSArray *array = dic[kAnswersArr];
    if (array.count > 0 ) {
        NSDictionary *answerDic = [array firstObject];
        cell.answerLabel.text = answerDic[kContent];
        [cell.likeBtn setTitle:[NSString stringWithFormat:@" %@", answerDic[kLikeNum]] forState:UIControlStateNormal];
    }
    
    NSArray *userArr = [BGDataUtil sharedInstance].usersArr;
    
    NSDictionary *userDic = userArr[indexPath.row % userArr.count];
    cell.userNameLabel.text = userDic[kUsreName];
    [cell.userAvatarBtn setImage:[UIImage imageNamed:userDic[kUsreAvatar]] forState:UIControlStateNormal];
}


#pragma mark - 
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animationDelegate;
}

//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return self.animationDelegate;
//    
//}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self.animationDelegate;
}



@end
