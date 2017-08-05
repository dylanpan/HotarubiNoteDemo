//
//  userRegisterViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotarubiNoteViewController.h"
#import "customAnimator.h"
#import "userRegisterRootViewController.h"
#import "userTestViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface userRegisterViewController : UINavigationController  <UINavigationControllerDelegate, UIViewControllerInteractiveTransitioning>//不需要？

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *myPanInteractiveTransition;
@property (nonatomic) BOOL isInteractive;

@end
