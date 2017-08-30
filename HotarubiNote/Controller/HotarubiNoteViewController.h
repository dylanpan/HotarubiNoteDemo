//
//  HotarubiNoteViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/4.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "customAnimator.h"
#import "newViewController.h"
#import "secondViewController.h"
#import "userRegisterViewController.h"
#import "coreDataManager.h"
#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"
#import "AppDelegate.h"

@interface HotarubiNoteViewController : UIViewController <UIViewControllerTransitioningDelegate, UITextFieldDelegate>

//typedef void(^loginUser)(NSString *name);
//@property (copy, nonatomic) loginUser loginUserBlock;
@property (weak, nonatomic) IBOutlet UILabel *applicationName;
@property (weak, nonatomic) IBOutlet UITextField *typeInUserName;
@property (weak, nonatomic) IBOutlet UITextField *typeInUserPassword;
@property (weak, nonatomic) IBOutlet UIButton *toSecondViewButton;
@property (weak, nonatomic) IBOutlet UIButton *toNewTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *toNewOneButton;


@property (strong, nonatomic) NSManagedObjectContext *userMOC;
@property (strong, nonatomic) NSFetchedResultsController *userFRC;
@property (strong, nonatomic) User *user;
@property (nonatomic) BOOL userDidnotExist;

- (IBAction)userLogin:(id)sender;
- (IBAction)userRegister:(id)sender;
- (IBAction)toNew:(id)sender;
- (IBAction)toSecondView:(id)sender;
- (IBAction)toNewTwo:(id)sender;
- (IBAction)userNameTextField_DidEndOnExit:(id)sender;
- (IBAction)userPasswordTextField_DidEndOnExit:(id)sender;
- (IBAction)View_TouchDown:(id)sender;


@end
