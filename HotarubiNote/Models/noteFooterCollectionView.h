//
//  noteFooterCollectionView.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteFooterCollectionView : UICollectionReusableView

@property (strong ,nonatomic) UILabel *noteLabelInFooter;

//底部视图的缓存池标示
+ (NSString *)footerViewIdentifier;

//获取底部视图对象
+ (instancetype)footerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end
