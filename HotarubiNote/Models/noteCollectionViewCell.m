//
//  noteCollectionViewCell.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteCollectionViewCell.h"

@implementation noteCollectionViewCell

+ (NSString *)collectionViewCellIdentifier{
    static NSString *collectionViewCellIdentifier = @"CollectionViewCellIdentifier";
    return collectionViewCellIdentifier;
}


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中寻找方块视图，若无，该方法自动调用alloc/initWithFrame创建并返回一个新的方块视图
    noteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[noteCollectionViewCell collectionViewCellIdentifier] forIndexPath:indexPath];
    return cell;
}

//后续注册方块视图后，当缓存池中没有方块视图的时候，自动调用alloc/initWithFrame创建
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //自定义cell
        UILabel *textLabel = [[UILabel alloc] init];
        CGFloat labelX = 5;
        CGFloat labelY = 5;
        CGFloat labelWidth = frame.size.width - 10;
        CGFloat labelHeight = frame.size.height - 10;
        textLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:textLabel];
        self.noteLabelInCell = textLabel;
    }
    return self;
}

@end
