//
//  maskLayerViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "maskAnimator.h"
#import "drawPhoto.h"

@interface maskLayerViewController : UIViewController <UIViewControllerTransitioningDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) UIImageView *myImageView;
@property (strong, nonatomic) UIImage *myImage;

- (IBAction)backX:(id)sender;

@end
