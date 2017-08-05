//
//  HotarubiNoteViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/4.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "customAnimator.h"
#import "newViewController.h"
#import "secondViewController.h"
#import "userRegisterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HotarubiNoteViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UILabel *applicationName;
@property (weak, nonatomic) IBOutlet UITextField *typeInUserName;
@property (weak, nonatomic) IBOutlet UITextField *typeInUserPassword;
@property (weak, nonatomic) IBOutlet UIButton *toSecondViewButton;


- (IBAction)userLogin:(id)sender;
- (IBAction)userRegister:(id)sender;
- (IBAction)toNew:(id)sender;
- (IBAction)toSecondView:(id)sender;
- (IBAction)toNewTwo:(id)sender;
- (IBAction)TextField_DidEndOnExit:(id)sender;
- (IBAction)View_TouchDown:(id)sender;


@end
