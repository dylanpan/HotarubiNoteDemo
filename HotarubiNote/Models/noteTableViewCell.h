//
//  noteTableViewCell.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawPhoto.h"
@class note;

@interface noteTableViewCell : UITableViewCell

@property (nonatomic, strong) note *oneNote;
@property (nonatomic, assign) CGFloat oneNoteHeight;//计算cell的高度

@property (nonatomic, strong) UILabel *noteCellTitle;
@property (nonatomic, strong) UILabel *noteCellStar;
@property (nonatomic, strong) UILabel *noteCellTime;
@property (nonatomic, strong) UILabel *noteCellContent;
@property (nonatomic, strong) UILabel *noteCellAuthor;
@property (nonatomic, strong) UIImageView *noteCellAuthorPhoto;
@property (nonatomic, strong) UIImageView *noteCellMainPhoto;

@end
