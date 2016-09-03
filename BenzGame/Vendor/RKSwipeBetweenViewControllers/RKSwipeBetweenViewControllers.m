//
//  RKSwipeBetweenViewControllers.m
//  RKSwipeBetweenViewControllers
//
//  Created by Richard Kim on 7/24/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for regular updates

#import "RKSwipeBetweenViewControllers.h"

//%%% customizeable button attributes
#define X_BUFFER 0 //%%% the number of pixels on either side of the segment
#define Y_BUFFER 14 //%%% number of pixels on top of the segment
#define HEIGHT 30 //%%% height of the segment

//%%% customizeable selector bar attributes (the black bar under the buttons)
#define ANIMATION_SPEED 0.2 //%%% the number of seconds it takes to complete the animation
#define SELECTOR_Y_BUFFER 40 //%%% the y-value of the bar that shows what page you are on (0 is the top)
#define SELECTOR_HEIGHT 4 //%%% thickness of the selector bar

#define X_OFFSET 8 //%%% for some reason there's a little bit of a glitchy offset.  I'm going to look for a better workaround in the future

@interface RKSwipeBetweenViewControllers () {
    
//    NSInteger currentPageIndex;
}

//@property (nonatomic, readwrite) NSInteger currentPageIndex;

@end

@implementation RKSwipeBetweenViewControllers
@synthesize viewControllerArray;
@synthesize selectionBar;
@synthesize panGestureRecognizer;
@synthesize navigationView;
@synthesize buttonText;
@synthesize currentPageIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self setupSelector];
    [self setupSegmentButtons];
    [self setupFirstPageViewController];    
}

//This stuff here is customizeable: buttons, views, etc
////////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%    CUSTOMIZEABLE    %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//

//%%% color of the status bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//%%% sets up the tabs using a loop.  You can take apart the loop to customize individual buttons, but remember to tag the buttons.  (button.tag=0 and the second button.tag=1, etc)
-(void)setupSegmentButtons {

}


//%%% sets up the selection bar under the buttons on the navigation bar
-(void)setupSelector {
    selectionBar = [[UIView alloc]initWithFrame:CGRectMake(X_BUFFER-X_OFFSET, SELECTOR_Y_BUFFER,(self.view.frame.size.width-2*X_BUFFER)/[viewControllerArray count], SELECTOR_HEIGHT)];
    selectionBar.backgroundColor = [UIColor greenColor]; //%%% sbcolor
    selectionBar.alpha = 0.8; //%%% sbalpha
    [navigationView addSubview:selectionBar];
}

//                                                        //
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%    CUSTOMIZEABLE    %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
////////////////////////////////////////////////////////////





//generally, this shouldn't be changed unless you know what you're changing
////////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%        SETUP       %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//                                                        //

-(void)viewWillAppear:(BOOL)animated {
    [self setupPageViewController];
//    [self setupSegmentButtons];
}

-(void)setupFirstPageViewController {
    if (!viewControllerArray) {
        return;
    }
    
    self.delegate = self;
    self.dataSource = self;

    [self setViewControllers:@[viewControllerArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    [self syncScrollView];
}

//%%% generic setup stuff for a pageview controller.  Sets up the scrolling style and delegate for the controller
-(void)setupPageViewController {
    self.delegate = self;
    self.dataSource = self;
    
    if (self.currentPageIndex != 0) {
        [self setViewControllers:@[self.viewControllerArray[(NSUInteger) self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL complete){
            if (complete) {
                NSLog(@"complete");
            }
        }];
    } else {
        [self setViewControllers:@[viewControllerArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }

    [self syncScrollView];
}

//%%% this allows us to get information back from the scrollview, namely the coordinate information that we can link to the selection bar.
-(void)syncScrollView {
    for (UIView* view in self.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            self.pageScrollView = (UIScrollView *)view;
            self.pageScrollView.delegate = self;
        }
    }
}


//                                                        //
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%        SETUP       %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
////////////////////////////////////////////////////////////




//%%% methods called when you tap a button or scroll through the pages
// generally shouldn't touch this unless you know what you're doing or
// have a particular performance thing in mind
//////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%        MOVEMENT         %%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//                                                      //

//%%% when you tap one of the buttons, it shows that page,
//but it also has to animate the other pages to make it feel like you're crossing a 2d expansion,
//so there's a loop that shows every view controller in the array up to the one you selected
//eg: if you're on page 1 and you click tab 3, then it shows you page 2 and then page 3
-(void)tapSegmentButtonAction:(UIButton *)button withAnimation:(BOOL)isAnimation completion:(void (^)(BOOL finished))completion
{
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    
    //%%% check to see if you're going left -> right or right -> left
    if (button.tag > tempIndex) {
        
        //%%% scroll through all the objects between the two points
        for (NSInteger i = (int)tempIndex+1; i<=button.tag; i++) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setViewControllers:@[viewControllerArray[i]] direction:UIPageViewControllerNavigationDirectionForward animated:isAnimation completion:^(BOOL complete){
                    
                    //%%% if the action finishes scrolling (i.e. the user doesn't stop it in the middle),
                    //then it updates the page that it's currently on
                    if (complete) {
//                        NSLog(@"complete");
                        [weakSelf updateCurrentPageIndex:i];
                    }
                    if (completion) {
                        completion(complete);
                    }
                }];
            });
        }
    }
    
    //%%% this is the same thing but for going right -> left
    else if (button.tag < tempIndex) {
        for (NSInteger i = (int)tempIndex-1; i >= button.tag; i--) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setViewControllers:@[viewControllerArray[i]] direction:UIPageViewControllerNavigationDirectionReverse animated:isAnimation completion:^(BOOL complete){
                    if (complete) {
                        [weakSelf updateCurrentPageIndex:i];
                    }
                    if (completion) {
                        completion(complete);
                    }
                }];
            });
        }
    } else {
        if (completion) {
            completion(YES);
        }
    }
    
}

-(void)tapSegmentButtonAction:(UIButton *)button completion:(void (^)(BOOL finished))completion
{
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    
    //%%% check to see if you're going left -> right or right -> left
    if (button.tag > tempIndex) {
        
        //%%% scroll through all the objects between the two points
        for (NSInteger i = (int)tempIndex+1; i<=button.tag; i++) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setViewControllers:@[viewControllerArray[i]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL complete){

                    //%%% if the action finishes scrolling (i.e. the user doesn't stop it in the middle),
                    //then it updates the page that it's currently on
                    if (complete) {
                        NSLog(@"complete");
                        [weakSelf updateCurrentPageIndex:i];
                    }
                    completion(complete);

                }];
            });
        }
    }
    
    //%%% this is the same thing but for going right -> left
    else if (button.tag < tempIndex) {
        for (NSInteger i = (int)tempIndex-1; i >= button.tag; i--) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setViewControllers:@[viewControllerArray[i]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL complete){
                    if (complete) {
                        [weakSelf updateCurrentPageIndex:i];
                    }
                    completion(complete);
                }];
            });
        }
    } else {
        completion(YES);
    }

}


//%%% makes sure the nav bar is always aware of what page you're on
//in reference to the array of view controllers you gave
-(void)updateCurrentPageIndex:(NSInteger)newIndex {
//    NSLog(@"updateCurrentPageIndex:%d",newIndex);
    currentPageIndex = newIndex;
    
    [self pageChangeFinish:currentPageIndex];
}

//%%% method is called when any of the pages moves.
//It extracts the xcoordinate from the center point and instructs the selection bar to move accordingly
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xFromCenter = self.view.frame.size.width-_pageScrollView.contentOffset.x; //%%% positive for right swipe, negative for left
    
    //%%% checks to see what page you are on and adjusts the xCoor accordingly.
    //i.e. if you're on the second page, it makes sure that the bar starts from the frame.origin.x of the
    //second tab instead of the beginning
    NSInteger xCoor = X_BUFFER+selectionBar.frame.size.width*currentPageIndex-X_OFFSET;
    
    selectionBar.frame = CGRectMake(xCoor-xFromCenter/[viewControllerArray count], selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
}

//                                                      //
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%         MOVEMENT         %%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//////////////////////////////////////////////////////////




//%%% the delegate functions for UIPageViewController.
//Pretty standard, but generally, don't touch this.
////////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%       UIPageViewController Delegate       %%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [viewControllerArray objectAtIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}


#pragma mark - UIPageViewControllerDelegate Methods
// Sent when a gesture-initiated transition begins.
//- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
//    NSLog(@"willTransitionToViewControllers:%@",pendingViewControllers);
//}


-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
//        currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
//        [self pageChangeFinish:currentPageIndex];
        [self updateCurrentPageIndex:[self indexOfController:[pageViewController.viewControllers lastObject]]];
    }
}


- (void)pageChangeFinish:(NSUInteger)currentIndex{
    //over write for child
}

//%%% checks to see which item we are currently looking at from the array of view controllers.
// not really a delegate method, but is used in all the delegate methods, so might as well include it here
-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[viewControllerArray count]; i++) {
        if (viewController == [viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%       UIPageViewController Delegate       %%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
////////////////////////////////////////////////////////////

@end
