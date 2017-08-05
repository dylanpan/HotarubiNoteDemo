//
//  modalNewTransitionContext.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/7.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "modalNewTransitionContext.h"

@implementation modalNewTransitionContext


- (instancetype) initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight{
    if ((self = [super init])){
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{
                                        UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        CGFloat travelDistance = (goingRight? -self.containerView.bounds.size.width:self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.containerView.bounds;
        self.privateAppearingToRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset(self.containerView.bounds, travelDistance, 0);
        self.privateAppearingFromRect = CGRectOffset(self.containerView.bounds, -travelDistance, 0);
    }
    NSLog(@"0\n");
    return self;
}

- (CGRect) initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]){
        NSLog(@"0.1\n");
        return self.privateDisappearingFromRect;
    }else{
        NSLog(@"0.2\n");
        return self.privateAppearingFromRect;
    }
}

- (CGRect) finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextToViewControllerKey]){
        NSLog(@"0.3\n");
        return self.privateDisappearingToRect;
    }else{
        NSLog(@"0.4\n");
        return self.privateAppearingToRect;
    }
}

- (UIViewController *) viewControllerForKey:(UITransitionContextViewControllerKey)key {
    NSLog(@"0.5\n");
    return self.privateViewControllers[key];
}

- (void) completeTransition:(BOOL)didComplete {
    if (self.completionBlock){
        NSLog(@"0.6\n");
        self.completionBlock(didComplete);
    }
}


@end
