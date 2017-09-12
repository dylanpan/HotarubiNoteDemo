//
//  editFriendInfoViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "noteMainTwoViewController.h"
#import "Friend+CoreDataClass.h"
#import "Friend+CoreDataProperties.h"
#import "coreDataManager.h"
#import "secondViewController.h"
#import "maskLayerViewController.h"

@interface editFriendInfoViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) UITextField *noteFriendNameTextField;
@property (strong, nonatomic) UITextField *noteFriendManifestoTextField;
@property (strong, nonatomic) UIButton *noteFriendPhotoButton;
@property (strong, nonatomic) UIImagePickerController *noteFriendPhotoPicker;
@property (strong, nonatomic) UIToolbar *noteFriendEditToolBar;
@property (strong, nonatomic) NSManagedObjectContext *friendMOC;
@property (strong, nonatomic) Friend *noteFriend;
@property (nonatomic, strong) NSMutableArray *sectionsEditArray;

//在story board中将对应view的Custom class属性项UIView设置成UIControl，然后才能进行关联
- (IBAction)View_TouchDown:(id)sender;
@end
