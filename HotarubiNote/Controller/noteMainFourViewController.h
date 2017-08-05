//
//  noteMainFourViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawPhoto.h"

@interface noteMainFourViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *noteMeSettingTableView;
@property (strong, nonatomic) NSMutableArray *noteMeSettings;

@end
