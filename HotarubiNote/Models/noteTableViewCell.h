//
//  noteTableViewCell.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "drawPhoto.h"
#import "HNote+CoreDataClass.h"
#import "HNote+CoreDataProperties.h"
#import "personalSettingViewController.h"
#import "noteMainOneViewController.h"

@class note;

@interface noteTableViewCell : UITableViewCell

typedef void(^transformView)(NSString *string);
@property (nonatomic, copy) transformView transformViewBlock;

@property (nonatomic, strong) note *oneNote;
@property (nonatomic, assign) CGFloat oneNoteHeight;//计算cell的高度
@property (nonatomic, copy) NSString *oneNoteHeightKey;

@property (nonatomic, strong) UILabel *noteCellTitle;
@property (nonatomic, strong) UILabel *noteCellStar;
@property (nonatomic, strong) UILabel *noteCellTime;
@property (nonatomic, strong) UILabel *noteCellContent;
@property (nonatomic, strong) UILabel *noteCellAuthor;
@property (nonatomic, strong) UIImageView *noteCellAuthorPhoto;
@property (nonatomic, strong) UIImageView *noteCellMainPhoto;

@end
