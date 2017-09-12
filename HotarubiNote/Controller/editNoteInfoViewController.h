//
//  editNoteInfoViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "noteMainViewController.h"
#import "maskLayerViewController.h"
#import "secondViewController.h"
#import "HNote+CoreDataClass.h"
#import "HNote+CoreDataProperties.h"
#import "coreDataManager.h"
#import "drawPhoto.h"

@interface editNoteInfoViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) NSDictionary *getData;
@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteSubtitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteLimitedTimeTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *noteContentPhotoImageView;
@property (strong, nonatomic) NSString *originatorName;
@property (strong, nonatomic) UIDatePicker *noteLimitedTimePicker;
@property (strong, nonatomic) UIPickerView *noteLocationPicker;
@property (strong, nonatomic) UIToolbar *noteInfoEditToolBar;
@property (strong, nonatomic) NSManagedObjectContext *hnoteMOC;
@property (strong, nonatomic) HNote *hnote;
@property (strong, nonatomic) UIViewController *sourceViewController;

@property (copy, nonatomic) NSArray *myLocationZone;
@property (copy, nonatomic) NSDictionary *myLocationCity;
@property (nonatomic) NSInteger selectZone;

- (IBAction)View_TouchDown:(id)sender;
- (IBAction)titleTextField_DidEndOnExit:(id)sender;
- (IBAction)subtitleTextField_DidEndOnExit:(id)sender;
- (IBAction)locationTextField_DidEndOnExit:(id)sender;
- (IBAction)limitedTimeTextField_DidEndOnExit:(id)sender;

@end
