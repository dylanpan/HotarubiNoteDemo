//
//  noteTableViewCell.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteTableViewCell.h"
#import "note.h"

//颜色宏
#define noteColor(r, g, b) [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1]
//控件间距
#define noteTableViewCellControlSpacing 10
//cell 背景色
#define noteTableViewCellBackgroundColor noteColor(251, 251, 251)
//
#define noteGrayColor noteColor(50, 50, 50)
//
#define noteLightGrayColor noteColor(120, 120, 120)
//头像初始位置X
#define noteTableViewCellAuthorPhotoX 5
//头像初始位置Y
#define noteTableViewCellAuthorPhotoY 5
//头像宽度
#define noteTableViewCellAuthorPhotoWidth 70
//头像高度
#define noteTableViewCellAuthorPhotoHeight noteTableViewCellAuthorPhotoWidth
//发布人名称字体大小
#define noteTableViewCellAuthorFontSize 14
//主标题字体大小
#define noteTableViewCellTitleFontSize 20
//星阶字体大小
#define noteTableViewCellStarFontSize 12
//限定时间字体大小
#define noteTableViewCellTimeFontSize 12
//内容字体大小
#define noteTableViewCellContentFontSize 14
//便签图片宽度
#define noteTableViewCellMainPhotoWidth 250
//便签图片高度
#define noteTableViewCellMainPhotoHeight 100

static CGRect oldframe;

@implementation noteTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNoteTableViewCell];
    }
    return self;
}

- (void) initNoteTableViewCell{
    //主标题 UILabel初始化
    self.noteCellTitle = [[UILabel alloc] init];
    self.noteCellTitle.textColor = noteGrayColor;
    self.noteCellTitle.font = [UIFont systemFontOfSize:noteTableViewCellTitleFontSize];
    [self.contentView addSubview:self.noteCellTitle];
    
    //星阶 UILabel初始化
    self.noteCellStar = [[UILabel alloc] init];
    self.noteCellStar.textColor = noteGrayColor;
    self.noteCellStar.font = [UIFont systemFontOfSize:noteTableViewCellStarFontSize];
    [self.contentView addSubview:self.noteCellStar];
    
    //限定时间 UILabel初始化
    self.noteCellTime = [[UILabel alloc] init];
    self.noteCellTime.textColor = noteLightGrayColor;
    self.noteCellTime.font = [UIFont systemFontOfSize:noteTableViewCellTimeFontSize];
    [self.contentView addSubview:self.noteCellTime];
    
    //便签内容 UILabel初始化
    self.noteCellContent = [[UILabel alloc] init];
    self.noteCellContent.textColor = noteGrayColor;
    self.noteCellContent.font = [UIFont systemFontOfSize:noteTableViewCellContentFontSize];
    self.noteCellContent.numberOfLines = 0;
    [self.contentView addSubview:self.noteCellContent];
    
    //发布人名称 UILabel初始化
    self.noteCellAuthor = [[UILabel alloc] init];
    self.noteCellAuthor.textColor = noteGrayColor;
    self.noteCellAuthor.font = [UIFont systemFontOfSize:noteTableViewCellAuthorFontSize];
    [self.contentView addSubview:self.noteCellAuthor];
    
    //发布人头像 UIImageView初始化
    self.noteCellAuthorPhoto = [[UIImageView alloc] init];
    [self.contentView addSubview:self.noteCellAuthorPhoto];
    
    //便签图片 UIImageView初始化
    self.noteCellMainPhoto = [[UIImageView alloc] init];
    [self.contentView addSubview:self.noteCellMainPhoto];
}

- (void) setOneNote:(note *)oneNote{
    //发布人头像 设置大小和位置
    CGFloat authorPhotoX = noteTableViewCellAuthorPhotoX;
    CGFloat authorPhotoY = noteTableViewCellAuthorPhotoY;
    CGRect authorPhotoRect = CGRectMake(authorPhotoX, authorPhotoY, noteTableViewCellAuthorPhotoWidth, noteTableViewCellAuthorPhotoHeight);
    self.noteCellAuthorPhoto.image = [[[drawPhoto alloc] init] drawPersonPhotoWithWidth:noteTableViewCellAuthorPhotoWidth height:noteTableViewCellAuthorPhotoHeight positionX:0.0 positionY:0.0 color:[UIColor orangeColor]];
    self.noteCellAuthorPhoto.frame = authorPhotoRect;
    self.noteCellAuthorPhoto.layer.borderWidth = 1.0;
    self.noteCellAuthorPhoto.layer.borderColor = [UIColor blackColor].CGColor;
    //添加手势，触发点击图片效果
    self.noteCellAuthorPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapAuthorPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAuthorPhoto)];
    [self.noteCellAuthorPhoto addGestureRecognizer:tapAuthorPhoto];
    
    //发布人名称 设置大小和位置
    CGSize authorSize = [oneNote.noteAuthor sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:noteTableViewCellAuthorFontSize]}];
    CGFloat authorX = (noteTableViewCellAuthorPhotoWidth+authorPhotoX)/2.0-authorSize.width/2.0;
    CGFloat authorY = CGRectGetMaxY(self.noteCellAuthorPhoto.frame) + noteTableViewCellControlSpacing;
    CGRect authorRect = CGRectMake(authorX, authorY, authorSize.width, authorSize.height);
    self.noteCellAuthor.text = oneNote.noteAuthor;
    self.noteCellAuthor.frame = authorRect;
    
    //主标题 设置大小和位置
    CGFloat titleX = CGRectGetMaxX(self.noteCellAuthorPhoto.frame) + noteTableViewCellControlSpacing;
    CGFloat titleY = authorPhotoY;
    CGSize titleSize = [oneNote.noteTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:noteTableViewCellTitleFontSize]}];
    CGRect titleRect = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    self.noteCellTitle.text = oneNote.noteTitle;
    self.noteCellTitle.frame = titleRect;
    
    //星阶 设置大小和位置
    CGFloat starX = titleX;
    CGFloat starY = CGRectGetMaxY(self.noteCellTitle.frame) + noteTableViewCellControlSpacing;
    CGSize starSize = [oneNote.noteStar sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:noteTableViewCellStarFontSize]}];
    CGRect starRect = CGRectMake(starX, starY, starSize.width, starSize.height);
    self.noteCellStar.text = oneNote.noteStar;
    self.noteCellStar.frame = starRect;
    
    //限定时间 设置大小和位置
    CGFloat timeX = starX;
    CGFloat timeY = CGRectGetMaxY(self.noteCellStar.frame) + noteTableViewCellControlSpacing;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateNoteString = [dateFormat stringFromDate:oneNote.noteTime];
    CGSize timeSize = [dateNoteString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:noteTableViewCellTimeFontSize]}];
    CGRect timeRect = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.noteCellTime.text = dateNoteString;
    self.noteCellTime.frame = timeRect;
    
    //便签内容 设置大小和位置
    CGFloat contentX = authorPhotoX + noteTableViewCellControlSpacing;
    CGFloat contentY = CGRectGetMaxY(self.noteCellAuthorPhoto.frame) + authorSize.height + noteTableViewCellControlSpacing*2;
    CGFloat contentWidth = self.frame.size.width - noteTableViewCellControlSpacing * 2;
    CGSize contentSize = [oneNote.noteContent boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:noteTableViewCellContentFontSize]}
                                                           context:nil].size;
    CGRect contentRect = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    self.noteCellContent.text = oneNote.noteContent;
    self.noteCellContent.frame = contentRect;
    
    //便签图片 设置大小和位置
    CGFloat mainPhotoX = authorPhotoX;
    CGFloat mainPhotoY = CGRectGetMaxY(self.noteCellContent.frame) + noteTableViewCellControlSpacing;
    //CGFloat mainPhotoY = authorY + contentSize.height + noteTableViewCellControlSpacing*2;
    CGRect mainPhotoRect = CGRectMake(mainPhotoX, mainPhotoY, noteTableViewCellMainPhotoWidth, noteTableViewCellMainPhotoHeight);
    self.noteCellMainPhoto.image = [[[drawPhoto alloc] init] drawContentPhotoWithWidth:noteTableViewCellMainPhotoWidth height:noteTableViewCellMainPhotoHeight positionX:0.0 positionY:0.0 color:[UIColor orangeColor]];
    self.noteCellMainPhoto.frame = mainPhotoRect;
    self.noteCellMainPhoto.layer.borderWidth = 1.0;
    self.noteCellMainPhoto.layer.borderColor = [UIColor blackColor].CGColor;
    //添加手势，全屏预览
    self.noteCellMainPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapMainPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainPhoto)];
    [self.noteCellMainPhoto addGestureRecognizer:tapMainPhoto];
    
    //cell的高度
    self.oneNoteHeight = CGRectGetMaxY(self.noteCellMainPhoto.frame) + noteTableViewCellControlSpacing;
    self.oneNoteHeightKey = [NSString stringWithFormat:@"%@-%@-%@",oneNote.noteAuthor,oneNote.noteTitle,dateNoteString];
}


- (void) tapAuthorPhoto{
    //点击头像，执行transformPersonalView方法实现页面跳转
    if (self.transformViewBlock != nil) {
        self.transformViewBlock(@"transformPersonalView");
    }
}



- (void) showMainPhoto{
    UIImage *image = self.noteCellMainPhoto.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [self.noteCellMainPhoto convertRect:self.noteCellMainPhoto.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMainPhoto:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0.0, ([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void) hideMainPhoto:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
















@end
