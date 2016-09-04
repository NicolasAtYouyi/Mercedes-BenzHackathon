//
//  HomePreViewController.m
//  YouYi
//
//  Created by Nicolas on 16/4/9.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "HomePreViewController.h"
#import "HomePreViewCell.h"
#import "HomeDetailViewController.h"


@interface HomePreViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *activityID;
@property (nonatomic, assign) NSInteger currentIndex;



@end

@implementation HomePreViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomePreViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAction:) name:@"changText" object:nil];

    
    [self loadData];
}



- (void)loadAction:(NSNotification *)notification {
    
    NSInteger index = [notification.object[@"index"] integerValue];
    self.currentIndex = index;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.dataArray.count == 0) {
        [self loadData];
    }
}

- (NSMutableDictionary *)activityID {
    if (_activityID != nil) {
        return _activityID;
    }
    
    self.activityID = [NSMutableDictionary dictionary];
    
    return _activityID;
}

- (void)loadData {
    
    
    self.dataArray = [NSMutableArray array];
//    for (int i = 0; i < 7; i++) {
        [self.dataArray addObject:@{@"image" : [NSString stringWithFormat:@"%d", 1], @"title" : @"全程奔驰越野直播", @"content" : @"活动对象:奔驰社区中称号为“俱乐部玩家”用户"}];
//    }
    
    [self.dataArray addObject:@{@"image" : [NSString stringWithFormat:@"%d", 2], @"title" : @"精英俱乐部夏日party", @"content" : @"活动对象:奔驰社区中称号为“俱乐部玩家”用户"}];
    [self.dataArray addObject:@{@"image" : [NSString stringWithFormat:@"%d", 3], @"title" : @"今天的活动是奔驰精英俱乐部及北大emba班联合组织的年度活动，参与活动人员素质极高，80%皆是名校及海归。", @"content" : @"活动对象:奔驰意向客户、活动新招募客户、老客户、车友、当地媒体·试驾车辆:5台(XV1台,傲虎1台,森林人2台,BRZ1台,BRZ不进行试驾)"}];


    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"freshContentSize" object:self.dataArray];
        [self.collectionView reloadData];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *home = self.dataArray[indexPath.row];
    [cell showData:home];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    HomeDetailViewController *homeDetailVC = [[HomeDetailViewController alloc] init];
//    [self.navigationController showViewController:homeDetailVC sender:nil];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"QuestionStoryboard" bundle:nil];
    UIViewController *detail = [story instantiateViewControllerWithIdentifier:@"BGActivityDetailViewController"];
    [self.navigationController pushViewController:detail animated:true];
    
}
    
    
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
