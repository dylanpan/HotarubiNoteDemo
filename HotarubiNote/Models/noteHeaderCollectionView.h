//
//  noteHeaderCollectionView.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteHeaderCollectionView : UICollectionReusableView


@property (strong ,nonatomic) UILabel *noteLabelInHeader;

//顶部视图的缓存池标示
+ (NSString *)headerViewIdentifier;

//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
