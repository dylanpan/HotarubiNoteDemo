//
//  modalNewTransitionContext.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/7.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "customAnimator.h"

@interface modalNewTransitionContext : NSObject  <UIViewControllerContextTransitioning>

@property (nonatomic, copy) void(^completionBlock)(BOOL didComplete);
@property (nonatomic, assign, getter=isAnimated) BOOL animated;
//@property (nonatomic, assign, getter=isInteractive) BOOL interactive;
@property (nonatomic, strong) NSDictionary *privateViewControllers;
@property (nonatomic, assign) CGRect privateDisappearingFromRect;
@property (nonatomic, assign) CGRect privateAppearingFromRect;
@property (nonatomic, assign) CGRect privateDisappearingToRect;
@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) UIModalTransitionStyle presentationStyle;

@property(nonatomic) CGAffineTransform targetTransform;
@property(nonatomic) BOOL transitionWasCancelled;

- (instancetype) initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight;

@end
