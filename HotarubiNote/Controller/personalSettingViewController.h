//
//  personalSettingViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/22.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "coreDataManager.h"
#import "HNote+CoreDataClass.h"
#import "HNote+CoreDataProperties.h"
#import "drawPhoto.h"

@interface personalSettingViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *authorPhoto;
@property (weak, nonatomic) IBOutlet UITextField *authorNameTextField;



@property (strong, nonatomic) UIToolbar *personalSettingToolBar;
@property (strong, nonatomic) UIImage *myPickImage;
@property (strong, nonatomic) UIImagePickerController *authorPhotoPicker;
@property (strong, nonatomic) NSManagedObjectContext *hnoteMOC;
@property (strong, nonatomic) HNote *hnote;

- (IBAction) authorNameTextField_DidEndOnExit:(id)sender;
- (IBAction) UIView_TouchDown:(id)sender;

@end
