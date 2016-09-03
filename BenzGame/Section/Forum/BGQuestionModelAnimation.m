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
        
        
        //Animation
        [[transitionContext containerView] addSubview:toVC.view];
        toVC.backBtn.alpha = 0.0;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = [self pathsType:YES];
        toVC.view.layer.mask = layer;
        toVC.view.clipsToBounds = YES;
        [layer addAnimation:[self scalingAnimation:[self pathsType:NO]] forKey:nil];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.backBtn.alpha = 1.0;
            fromVC.view.alpha = 0.8;
            
        } completion:^(BOOL finished) {
            fromVC.view.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    //Back to cover VC
    else {
        BGQuestionDetailViewController *fromVC = (BGQuestionDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        BGQuestionListViewController *toVC = (BGQuestionListViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        
        //Animation
        [[transitionContext containerView] insertSubview:toVC.view atIndex:0];
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = [self pathsType:NO];
        fromVC.view.layer.mask = layer;
        fromVC.view.clipsToBounds = YES;
        [layer addAnimation:[self scalingAnimation:[self pathsType:YES]] forKey:nil];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.alpha = 0.8;
            
        } completion:^(BOOL finished) {
            fromVC.view.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

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
