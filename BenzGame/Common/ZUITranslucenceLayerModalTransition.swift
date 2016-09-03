//
//  ZUITranslucenceLayerModalTransition.swift
//  ZUIVogue
//
//  Created by lz on 16/5/19.
//  Copyright © 2016年 ___ZUI___. All rights reserved.
//

import UIKit
enum ZUITranslucenceLayerModalTransitionType:Int {
    case Modal,ActionSheet
}

class ZUITranslucenceLayerModalTransition: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    var transType:ZUITranslucenceLayerModalTransitionType = .Modal
    var transitioning = false
    var presenting = true
    var interactive = false
    var transitionContext:UIViewControllerContextTransitioning!
    var container:UIView!
    
    
    var size:CGSize{
        return container.bounds.size
    }
    var frontView:UIView{
        return frontViewController.view
    }
    var backView:UIView{
        return backViewController.view
    }
    var frontViewController: UIViewController{
        return presenting ? toViewController : fromViewController
    }
    var backViewController: UIViewController{
        return !presenting ? toViewController : fromViewController
    }
    var toView:UIView{
        return toViewController.view
//        return  transitionContext.viewForKey(UITransitionContextToViewKey)!
    }
    var fromView:UIView{
        return fromViewController.view
//        return transitionContext.viewForKey(UITransitionContextFromViewKey)!
    }
    var toViewController:UIViewController{
        return transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    }
    var fromViewController:UIViewController{
        return transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    }

    func setup(){
        transitioning = true

        backViewController.viewWillDisappear(true)
        
        container.insertSubview(backView, atIndex: 0)
        container.addSubview(frontView)
        
        setupOverlayView()
    }
    
    var overlayView = UIView()

    func setupOverlayView(){
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(overlayTapped(_:)))

        overlayView.opaque = false
        overlayView.addGestureRecognizer(tapGR)
        overlayView.userInteractionEnabled = true
//        overlayView.layer.zPosition = 298
        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        overlayView.frame = container.bounds
        container.insertSubview(overlayView, aboveSubview: backView)
    }
    
    func overlayTapped(tapGR:UITapGestureRecognizer){
//        presentedViewController!.dismissViewControllerAnimated(true, completion:nil)
    }
    
//    var presentedViewController:UIViewController?
    
    func clean(finished: Bool){
        UIApplication.sharedApplication().keyWindow!.addSubview(finished ? toView : fromView)
        
        if(!presenting && finished || presenting && !finished){
            frontView.removeFromSuperview()
            overlayView.removeFromSuperview()
            backViewController.viewDidAppear(true)
        }
        
        if finished {
            if presenting {
                toViewController.viewDidAppear(true)
            }
        } else {
            fromViewController.viewDidAppear(true)
        }
        
        interactive = false
        transitioning = false
        transitionContext.completeTransition(finished)
        transitionContext = nil
        container = nil
    }


    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if transitioning {
            return
        }
        
        self.transitionContext = transitionContext
        self.container = transitionContext.containerView()
        
        setup()
        
        if presenting {
            let transitionDuration = self.transitionDuration(transitionContext)
            
            switch transType {
                case .Modal:
                    toView.alpha = 0.0
                    overlayView.alpha = 0.0
                    toView.transform = CGAffineTransformMakeScale(1.2, 1.2)

                    UIView.animateWithDuration(transitionDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { () -> Void in
                        self.fromView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                        self.overlayView.alpha = 1.0
                        self.toView.alpha = 1.0
                        self.toView.transform = CGAffineTransformIdentity
                    }) { (finished: Bool) -> Void in
                        let wasCancelled = self.transitionContext.transitionWasCancelled()
                        self.clean(!wasCancelled)
                    }
                case .ActionSheet:
                    overlayView.alpha = 0.0
                    toView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.size.height)

                    UIView.animateWithDuration(transitionDuration/2, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                        self.overlayView.alpha = 1.0
                        self.toView.transform = CGAffineTransformIdentity
                    }) { (finished: Bool) -> Void in
                        let wasCancelled = self.transitionContext.transitionWasCancelled()
                        self.clean(!wasCancelled)
                    }
            }
        } else {
            let transitionDuration = self.transitionDuration(transitionContext)
            switch transType {
            case .Modal:
                UIView.animateWithDuration(transitionDuration/2, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                    self.fromView.alpha = 0
                    self.overlayView.alpha = 0.0
                }) { (finished: Bool) -> Void in
                }
                
                UIView.animateWithDuration(transitionDuration/2, delay: 0.1, options: .CurveEaseInOut, animations: { () -> Void in
                    self.toView.transform = CGAffineTransformIdentity
                    self.fromView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                }) { (finished: Bool) -> Void in
                    let wasCancelled = self.transitionContext.transitionWasCancelled()
                    self.clean(!wasCancelled)
                }
            case .ActionSheet:
                UIView.animateWithDuration(transitionDuration/2, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                    self.overlayView.alpha = 0.0
                }) { (finished: Bool) -> Void in
                }
                
                UIView.animateWithDuration(transitionDuration/2, delay: 0.1, options: .CurveEaseInOut, animations: { () -> Void in
                    self.fromView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.size.height)
                }) { (finished: Bool) -> Void in
                    let wasCancelled = self.transitionContext.transitionWasCancelled()
                    self.clean(!wasCancelled)
                }

            }
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if transitioning{
            return nil
        }
        self.presenting = true
//        presentedViewController = presenting

        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if transitioning{
            return nil
        }
        self.presenting = false

        return self
    }
}
