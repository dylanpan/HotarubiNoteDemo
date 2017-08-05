//
//  customAnimator.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/6.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "customAnimator.h"

@implementation customAnimator

#pragma mark - animatation protocol method

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSTimeInterval myDuration = 0.5;
    return myDuration;
}


- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //UIViewControllerContextTransitioning是否需要进行重写协议中的方法？
    
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //没有storyboard进行连线会存在问题，动画结束后没有正确展示destination view
    //UIView *destinationView = destinationViewController.view;
    //UIView *souceView = souceViewController.view;
    UIView *destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *sourceView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    NSLog(@"customAnimator.m\nenter animated transition\n");
    
    [containerView addSubview:destinationView];
    //UIView *dimmingView = [[UIView alloc] init];
    
    if ([destinationViewController isBeingPresented] || (self.operation == UINavigationControllerOperationPush) || (self.tabTransitionType == TabBarTransitionRight)){
        
        //[containerView insertSubview:dimmingView belowSubview:destinationView];
        
        destinationView.backgroundColor = [UIColor greenColor];
        
        CGFloat destinationViewWidth = containerView.frame.size.width;// * 2/3;
        CGFloat destinationViewHeight = containerView.frame.size.height;// * 2/3;
        destinationView.center = containerView.center;
        destinationView.bounds = CGRectMake(0.0, 0.0, 1.0, destinationViewHeight);
        
        //dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        //dimmingView.center = containerView.center;
        //dimmingView.bounds = CGRectMake(0.0, 0.0, destinationViewWidth, destinationViewHeight);
        
        NSTimeInterval myDuration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:myDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             destinationView.bounds = CGRectMake(0.0, 0.0, destinationViewWidth, destinationViewHeight);
                             //dimmingView.bounds = [containerView bounds];
                         } completion:^(BOOL finished) {
                             BOOL isCancelled = transitionContext.transitionWasCancelled;
                             [transitionContext completeTransition:!isCancelled];
                             NSLog(@"customAnimator.m\npresent or push or right view animated finish\n");
                         }];
        NSLog(@"customAnimator.m\npresent view animated successed\n");
    }else{
        NSLog(@"customAnimator.m\npresent view animated failed\n");
    }
    
    if ([sourceViewController isBeingDismissed] || (self.operation == UINavigationControllerOperationPop) || (self.tabTransitionType == TabBarTransitionLeft)){
        CGFloat sourceViewHeihgt = sourceView.frame.size.height;
        [containerView sendSubviewToBack:destinationView];
        destinationView.backgroundColor = [UIColor orangeColor];
        
        NSTimeInterval myDuration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:myDuration
                         animations:^{
                             sourceView.bounds = CGRectMake(0.0, 0.0, 1.0, sourceViewHeihgt);
                         }
                         completion:^(BOOL finished) {
                             BOOL isCancelled = transitionContext.transitionWasCancelled;
                             [transitionContext completeTransition:!isCancelled];
                             NSLog(@"customAnimator.m\ndismiss or pop or left view animated finish\n");
                         }];
        NSLog(@"customAnimator.m\ndismiss view animated successed\n");
    }else{
        NSLog(@"customAnimator.m\ndismiss view animated failed\n");
    }
}

@end
