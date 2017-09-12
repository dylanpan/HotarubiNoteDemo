//
//  maskLayerViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawPhoto.h"
#import "editNoteInfoViewController.h"

@class maskLayerViewController;
@protocol maskLayerViewControllerDelegate <NSObject>

- (void) dismissPresentedViewControllerTwo:(maskLayerViewController *)viewController;

@end

@interface maskLayerViewController : UIViewController <UIViewControllerTransitioningDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) id<maskLayerViewControllerDelegate> maskLayerDelegate;

@property (nonatomic, copy) NSDictionary *sentData;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) UIImageView *myImageView;
@property (strong, nonatomic) UIImage *myImage;



- (IBAction)touchUpInsideCancelButton:(id)sender;
- (IBAction)touchUpInsideDoneButton:(id)sender;

@end
