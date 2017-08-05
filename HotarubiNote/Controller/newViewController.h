//
//  newViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customAnimator.h"

@interface newViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (copy,nonatomic) NSString *myLabelText;

- (IBAction)backToo:(id)sender;

@end
