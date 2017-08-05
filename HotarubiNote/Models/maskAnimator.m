//
//  maskAnimator.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "maskAnimator.h"

@implementation maskAnimator

#pragma mark - animatation protocol method

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSTimeInterval myDuration = 0.5;
    return myDuration;
}


- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.storeTransitionContext = transitionContext;
    
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *sourceView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    NSLog(@"maskAnimator.m\nenter animated transition\n");
    
    CGRect initialRect = CGRectMake(20.0, 20.0, 50.0, 50.0);
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:initialRect];
    CGRect finalRect = CGRectInset(initialRect, -1000, -1000);
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:finalRect];
    
    
    if ([destinationViewController isBeingPresented]){
        [containerView addSubview:destinationView];
        
        CAShapeLayer *maskShapeLayer = [[CAShapeLayer alloc] init];
        maskShapeLayer.path = circleMaskPathFinal.CGPath;
        destinationView.layer.mask = maskShapeLayer;
        
        CABasicAnimation *maskShapeLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskShapeLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
        maskShapeLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
        maskShapeLayerAnimation.duration = [self transitionDuration:transitionContext];
        maskShapeLayerAnimation.delegate = self;
        
        [maskShapeLayer addAnimation:maskShapeLayerAnimation forKey:@"path"];
        NSLog(@"maskAnimator.m\npresent view animated successed\n");
    }else{
        NSLog(@"maskAnimator.m\npresent view animated failed\n");
    }
    
    if ([sourceViewController isBeingDismissed]){
        
        CAShapeLayer *maskShapeLayer = [[CAShapeLayer alloc] init];
        maskShapeLayer.path = circleMaskPathInitial.CGPath;
        sourceView.layer.mask = maskShapeLayer;
        
        CABasicAnimation *maskShapeLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskShapeLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
        maskShapeLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
        maskShapeLayerAnimation.duration = [self transitionDuration:transitionContext];
        maskShapeLayerAnimation.delegate = self;
        
        [maskShapeLayer addAnimation:maskShapeLayerAnimation forKey:@"path"];
        NSLog(@"maskAnimator.m\ndismiss view animated successed\n");
    }else{
        NSLog(@"maskAnimator.m\ndismiss view animated failed\n");
    }
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    BOOL isCancelled = self.storeTransitionContext.transitionWasCancelled;
    [self.storeTransitionContext completeTransition:!isCancelled];
    UIViewController *destinationViewContoller = [self.storeTransitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    destinationViewContoller.view.layer.mask = nil;
    NSLog(@"maskAnimator.m\nanimation stop\n");
}



@end
