//
//  noteMainOneViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "note.h"
#import "noteTableViewCell.h"


@interface noteMainOneViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *noteMainTableView;
@property (strong, nonatomic) UIToolbar *noteMainToolBar;

@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) NSMutableArray *noteCells;//用于计算高度
@property (nonatomic) BOOL isInsert;

@end
