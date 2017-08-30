//
//  userRegisterRootViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "coreDataManager.h"
#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"
#import "userRegisterViewController.h"
#import "userTestViewController.h"
#import "customAnimator.h"
#import "noteMainViewController.h"

@interface userRegisterRootViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNewPasswordComfirmTextField;
@property (weak, nonatomic) IBOutlet UIButton *TestButton;

@property (strong, nonatomic) NSManagedObjectContext *userMOC;
@property (strong, nonatomic) NSFetchedResultsController *userFRC;
@property (strong ,nonatomic) User *user;

- (IBAction)toLoginView:(id)sender;
- (IBAction)toUserTestView:(id)sender;
- (IBAction)toMainOneView:(id)sender;

- (IBAction)userNameTextField_DidEndOnExit:(id)sender;
- (IBAction)userPasswordTextField_DidEndOnExit:(id)sender;
- (IBAction)userPasswordComfirmTextField_DidEndOnExit:(id)sender;
- (IBAction)UIView_TouchDown:(id)sender;
@end
