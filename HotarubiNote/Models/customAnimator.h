//
//  customAnimator.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/6.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HotarubiNoteViewController.h"
#import "userRegisterViewController.h"
#import "noteMainViewController.h"

@interface customAnimator : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

typedef NS_ENUM(NSInteger,tabBarTransitionType){
    TabBarTransitionLeft = 3,
    TabBarTransitionRight = 4
};
@property (nonatomic) UINavigationControllerOperation operation;
@property (nonatomic) tabBarTransitionType tabTransitionType;



@end
