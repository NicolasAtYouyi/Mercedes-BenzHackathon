//
//  BGQuestionModelAnimation.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGQuestionModelAnimation.h"
#import "BGQuestionListViewController.h"
#import "BGQuestionDetailViewController.h"

@interface BGQuestionModelAnimation () 

@end

@implementation BGQuestionModelAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .45;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //TO Detail
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[BGQuestionDetailViewController class]]) {
        
        // Get from and to VC.
        BGQuestionDetailViewController *toVC = (BGQuestionDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        BGQuestionListViewController *fromVC = (BGQuestionListViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        
//        UIImage *blurredImage;
//        if ([fromVC isKindOfClass:[CDCollectionViewController class]]) {
//            CDCollectionViewCell *cell = fromVC.collectionView.visibleCells.firstObject;
//            blurredImage = cell.bkgImageView.image;
//        }
//        else if ([fromVC isKindOfClass:[UINavigationController class]]) {
//            fromVC = (CDCollectionViewController *)((UINavigationController *)fromVC).topViewController;
//        }
//        
//        CDCollectionViewCell *cell = fromVC.collectionView.visibleCells.firstObject;
//        blurredImage = cell.bkgImageView.image;
//        toVC.bkgImageView.image = blurredImage;
//        toVC.bkgImageView.contentMode = UIViewContentModeScaleAspectFill;
//        
        //Animation
        [[transitionContext containerView] addSubview:toVC.view];
        toVC.titleView.alpha = 0.0;
//        toVC.bkgImageView.hidden = YES;
        
//        
//        NSArray *array = [NSArray arrayWithObjects:toVC.viewEdit,toVC.viewDownLoad,toVC.viewDelete,toVC.viewShare,toVC.viewAdd, nil];
//        for (int i=0; i<array.count; i++) {
//            UIView *v = array[i];
//            
//            NSTimeInterval delay = i * 0.06f;
//            
//            v.alpha = 0.2f;
//            [v setTransform:CGAffineTransformMakeScale(1.5, 1.5f)];
//            
//            CGPoint originalCenter  = v.center;
//            v.center = CGPointMake(originalCenter.x-300.0f, originalCenter.y-10.0f);
//            
//            [UIView animateWithDuration:0.8
//                                  delay:delay
//                 usingSpringWithDamping:0.8
//                  initialSpringVelocity:0.3
//                                options:UIViewAnimationOptionCurveEaseIn
//                             animations:^{
//                                 v.alpha = 1.0f;
//                                 [v setTransform:CGAffineTransformMakeScale(1.0, 1.0f)];
//                                 v.center = originalCenter;
//                             }
//                             completion:^(BOOL finished) {
//                             }];
//        }
//        
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = [self pathsType:YES];
        toVC.view.layer.mask = layer;
        toVC.view.clipsToBounds = YES;
        [layer addAnimation:[self scalingAnimation:[self pathsType:NO]] forKey:nil];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.titleView.alpha = 1.0;
//            layer.path = [self pathsType:NO];
            
        } completion:^(BOOL finished) {
//            toVC.bkgImageView.hidden = NO;
//            
//            fromVC.view.alpha = 1.0f;
//            cell.shadowView.alpha = 1.0f;
//            cell.titleShadowView.alpha = 1.0f;
//            fromVC.labelContentView.alpha = 1.0f;
//            fromVC.shadowView.alpha = 1.0f;
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    //Back to cover VC
    else {
        
//        CDShareViewController *fromVC = (CDShareViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        CDCollectionViewController *toVC = (CDCollectionViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        
//        
//        [[transitionContext containerView] addSubview:toVC.view];
//        [[transitionContext containerView] sendSubviewToBack:toVC.view];
//        fromVC.bkgImageView.hidden = YES;
//        // 2. Set init frame for toVC
//        CGRect screenBounds = [[UIScreen mainScreen] bounds];
//        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//        finalFrame = CGRectOffset(finalFrame, -screenBounds.size.height, 0);
//        
//        CDCollectionViewCell *cell;
//        if ([toVC isKindOfClass:[UINavigationController class]]) {
//            CDCollectionViewController *vc = (CDCollectionViewController *)((UINavigationController *)toVC).topViewController;
//            cell = vc.collectionView.visibleCells.firstObject;
//            toVC = vc;
//        }
//        else {
//            cell = toVC.collectionView.visibleCells.firstObject;
//        }
//        
//        NSArray *array = [NSArray arrayWithObjects:fromVC.viewEdit,fromVC.viewDownLoad,fromVC.viewDelete,fromVC.viewShare,fromVC.viewAdd, nil];
//        for (int i=0; i<array.count; i++) {
//            UIView *v = array[i];
//            
//            NSTimeInterval delay = i * 0.06f;
//            
//            [v setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
//            
//            CGPoint originalCenter  = v.center;
//            
//            
//            [UIView animateWithDuration:0.5
//                                  delay:delay
//                 usingSpringWithDamping:0.8
//                  initialSpringVelocity:0.3
//                                options:UIViewAnimationOptionCurveEaseIn
//                             animations:^{
//                                 v.alpha = 0.2f;
//                                 v.center = CGPointMake(originalCenter.x-300.0f, originalCenter.y-10.0f);
//                             }
//                             completion:^(BOOL finished) {
//                             }];
//        }
//        
//        
//        toVC.view.alpha = 0.5f;
//        toVC.labelContentView.alpha = 0.0f;
//        toVC.shadowView.alpha = 0.0f;
//        cell.shadowView.alpha = 0.0f;
//        cell.titleShadowView.alpha = 0.0f;
//        
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:.3f options:UIViewAnimationOptionCurveEaseIn
//                         animations:^{
//                             fromVC.bkgImageView.alpha = 1.0f;
//                             
//                             toVC.view.alpha = 1.0f;
//                             cell.shadowView.alpha = 1.0f;
//                             cell.titleShadowView.alpha = 1.0f;
//                             toVC.labelContentView.alpha = 1.0f;
//                             toVC.shadowView.alpha = 1.0f;
//                         } completion:^(BOOL finished) {
//                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                         }];
    }

    
}

- (CABasicAnimation *) scalingAnimation:(CGPathRef)destinationPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id _Nullable)(destinationPath);
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeBoth;
    animation.duration = 0.45;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    return animation;

}
- (CGPathRef) pathsType: (bool)isStart{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGPoint circleOrigin = CGPointMake(0, 0);
    
    float rw = width + fabs(width/2 - circleOrigin.x);
    CGFloat rh = height + fabs(height/2 - circleOrigin.y);
    CGFloat h1 = hypot(width/2 - circleOrigin.x, height/2 - circleOrigin.y);
    CGFloat hyp = (sqrtf(powf(rw, 2) + powf(rh, 2)));
    CGFloat dia = h1 + hyp;

    
    UIBezierPath * path;
    if (isStart) {
        
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectZero];
    } else {
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-dia/2, -dia/2, dia, dia)];
    }
    
    return path.CGPath;
}

//private func startAndEndPaths(shouldUnwind: Bool) -> (start: CGPathRef, end: CGPathRef) {
//    
//    // The hypothenuse is the diagonal of the screen.
//    // Further, we use this diagonal as the diameter of the big circle.
//    // This way we are always certain that the big circle will cover the whole screen.
//    // TODO: Clean up below implementation
//    let width = UIScreen.mainScreen().bounds.size.width
//    let height = UIScreen.mainScreen().bounds.size.height
//    let rw = width + fabs(width/2 - circleOrigin.x)
//    let rh = height + fabs(height/2 - circleOrigin.y)
//    let h1 = hypot(width/2 - circleOrigin.x, height/2 - circleOrigin.y)
//    let hyp = CGFloat(sqrtf(powf(Float(rw), 2) + powf(Float(rh), 2)))
//    let dia = h1 + hyp
//    
//    //print("h1: \(h1) hyp: \(hyp) rw: \(rw) rh: \(rh) width: \(width) height: \(height)")
//    
//    // The two circle sizes we will animate to/from
//    let path1 = UIBezierPath(ovalInRect: CGRectZero).CGPath
//    let path2 = UIBezierPath(ovalInRect: CGRectMake(-dia/2, -dia/2, dia, dia)).CGPath
//    
//    // If shouldUnwind flag is true, we should go from big to small circle, or else go from small to big
//    return shouldUnwind ? (path1, path2) : (path2, path1)
//}

@end
