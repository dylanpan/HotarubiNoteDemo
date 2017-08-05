//
//  noteCollectionViewCell.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteCollectionViewCell : UICollectionViewCell

@property (strong ,nonatomic) UILabel *noteLabelInCell;

//方块视图的缓存池标示
+ (NSString *)collectionViewCellIdentifier;

//获取方块视图对象
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
