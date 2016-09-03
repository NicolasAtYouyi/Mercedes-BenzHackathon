//
//  MineViewController.m
//  BenzGame
//
//  Created by Nicolas on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "MineViewController.h"


#define headRect CGRectMake(0,0,self.view.bounds.size.width,594 / 2.)//280
#define VCWidth self.view.bounds.size.width
#define VCHeight self.view.bounds.size.height
#define navHeight 44 //上推留下的高度




@interface HeadView:UIView

@property (weak, nonatomic) UIImageView * backgroundView;
@property (weak, nonatomic) UIImageView * headView;
@property (weak, nonatomic) UILabel * signLabel;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame backgroundView:(NSString *)name headView:(NSString *)headImgName headViewWidth:(CGFloat)width signLabel:(NSString *)signature {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -navHeight, frame.size.width, frame.size.height)];
        UIImage * image = [UIImage imageNamed:name];
        UIImage * newImg = [self image:image byScalingToSize:self.bounds.size];
        backgroundView.image = newImg;
        backgroundView.clipsToBounds = YES;
        [self addSubview:backgroundView];
        _backgroundView = backgroundView;
        
        UIView *grayView = [[UIView alloc] initWithFrame:backgroundView.bounds];
        grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
        
        
        
        //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
        [grayView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:grayView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:grayView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:grayView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//        NSLayoutConstraint *contraint5 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:70.0];
        //把约束添加到父视图上
        NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
        [_backgroundView addConstraints:array];
        
        
        
        [_backgroundView addSubview:grayView];
        
        UIImageView * headView = [[UIImageView alloc]initWithFrame:(CGRect){(frame.size.width - width) * 0.5,0.5 * (frame.size.height - width) - navHeight,width,width}];
        headView.layer.cornerRadius = width * 0.5;
        headView.layer.masksToBounds = YES;
        headView.image = [UIImage imageNamed:headImgName];
        [self addSubview:headView];
        _headView = headView;
        
        UILabel * signLabel = [[UILabel alloc]initWithFrame:(CGRect){0,CGRectGetMaxY(headView.frame) ,self.bounds.size.width,40}];
        signLabel.text = signature;
        signLabel.textAlignment = NSTextAlignmentCenter;
        signLabel.textColor = [UIColor whiteColor];
        [self addSubview:signLabel];
        _signLabel = signLabel;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_signLabel.frame), ScreenWidth - 20 * 2, 40)];
        imageView.image = [UIImage imageNamed:@"level"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.backgroundColor = [UIColor yellowColor];
        [_signLabel addSubview:imageView];
    }
    return self;
}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

@end





@interface MineViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) UITableView *myTableView;
@property (weak, nonatomic) HeadView * myView;
@property (strong, nonatomic) NSArray * dataArray;




@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    self.dataArray = @[@"我的问题", @"我的回答", @"我的收藏", @"个人信用认证", @"绑定身份"];

}

- (void)initUI {
    
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight, VCWidth, VCHeight - navHeight)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.contentInset = UIEdgeInsetsMake(headRect.size.height-navHeight-navHeight, 0, 0, 0);
    _myTableView = myTableView;
    myTableView.tableFooterView = [UIView new];
    
    [self.view addSubview:myTableView];
    
    HeadView * vc = [[HeadView alloc] initWithFrame:headRect backgroundView:@"1.jpg" headView:@"2.jpg" headViewWidth:(CGFloat)(VCWidth / 4) signLabel:@"Bear Out"];
    
    _myView = vc;
    _myView.backgroundColor = [UIColor clearColor];
    _myView.userInteractionEnabled = NO;
    [self.view addSubview:vc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

#pragma mark - tableview dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"StevenCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 22, 0, 22);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120 / 2.;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset_Y = scrollView.contentOffset.y + headRect.size.height-navHeight-navHeight;
    
    if  (offset_Y < 0) {
        
        _myView.backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        _myView.backgroundView.frame = CGRectMake(offset_Y*0.5 , -navHeight, VCWidth - offset_Y, headRect.size.height - offset_Y);
    }else if (offset_Y > 0 && offset_Y <= (headRect.size.height-navHeight-navHeight)) {
        
        _myView.backgroundView.contentMode = UIViewContentModeTop;
        
        _myView.backgroundView.frame = CGRectMake(0 ,navHeight* offset_Y/(headRect.size.height-navHeight-navHeight)-navHeight , VCWidth , headRect.size.height -(navHeight + navHeight* offset_Y/(headRect.size.height-navHeight-navHeight)-navHeight) - offset_Y);
        
        
        CGFloat width = offset_Y*(40-(VCWidth / 4))/(headRect.size.height-navHeight-navHeight)+(VCWidth / 4);
        _myView.headView.frame =CGRectMake(0, 0, width,width);
        _myView.headView.layer.cornerRadius =width*0.5;
        _myView.headView.center = _myView.backgroundView.center;
        
        _myView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(_myView.headView.frame), VCWidth, 40);
        
        _myView.signLabel.alpha = 1 - (offset_Y*3 / (headRect.size.height-navHeight-navHeight) /2);
    }
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



