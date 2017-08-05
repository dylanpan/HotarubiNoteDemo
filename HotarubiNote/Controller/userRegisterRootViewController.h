//
//  userRegisterRootViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userRegisterViewController.h"
#import "userTestViewController.h"
#import "customAnimator.h"

@interface userRegisterRootViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *userNewPasswordComfirm;

- (IBAction)toLoginView:(id)sender;
- (IBAction)toUserTestView:(id)sender;


@end
