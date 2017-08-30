//
//  secondViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/7.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotarubiNoteViewController.h"
#import "maskAnimator.h"
#import "maskLayerViewController.h"
#import "noteCollectionViewCell.h"
#import "noteHeaderCollectionView.h"
#import "noteFooterCollectionView.h"
#import "editNoteInfoViewController.h"

@class secondViewController;
@protocol secondViewControllerDelegate <NSObject>

- (void) dismissPresentedViewController:(secondViewController *)viewController;

@end

@interface secondViewController : UIViewController <UIViewControllerTransitioningDelegate, NSURLSessionDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *secondLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressBar;
@property (weak, nonatomic) IBOutlet UIButton *pickButton;
@property (weak, nonatomic) IBOutlet UIButton *backAsWellButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) UIImageView *URLImageView;
@property (strong, nonatomic) UIImage *URLImage;

@property (weak, nonatomic) id<secondViewControllerDelegate> secondDelegate;
@property (strong, atomic) NSURLRequest *myRequest;
@property (strong, atomic) NSURLConnection *myConnection;
@property (strong, atomic) NSMutableData *myData;
@property (strong, atomic) NSData *myPartialData;
@property (strong, atomic) NSURLResponse *myResponse;
@property (strong, atomic) NSURLSessionDownloadTask *myDownloadTask;
@property (strong, atomic) NSURLSessionDataTask *myDataTask;
@property (strong, atomic) NSURLSession *mySession;

@property (copy, nonatomic) NSString *secondLabelTwoText;
@property (copy, nonatomic) NSString *secondLabelText;
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) NSArray *myPhotoURLArray;
@property (strong, nonatomic) NSArray *myPhotoNameArray;

@property (copy, nonatomic) NSDictionary *saveData;

- (IBAction)backAsWell:(id)sender;
- (IBAction)toX:(id)sender;
- (IBAction)back:(id)sender;

@end
