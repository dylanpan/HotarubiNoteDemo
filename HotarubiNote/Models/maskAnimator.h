//
//  maskAnimator.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface maskAnimator : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (weak, nonatomic) id<UIViewControllerContextTransitioning> storeTransitionContext;
@end
