//
//  noteMainViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotarubiNoteViewController.h"
#import "customAnimator.h"

@interface noteMainViewController : UITabBarController <UITabBarControllerDelegate, UIViewControllerInteractiveTransitioning>

@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userPassword;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *myPanInteractiveTransition;
@property (nonatomic) BOOL isInteractive;

@end
