//
//  noteHeaderCollectionView.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteHeaderCollectionView.h"

@implementation noteHeaderCollectionView

+ (NSString *)headerViewIdentifier{
    
    static NSString *headerViewIdentifier = @"HeaderViewIdentifier";
    return headerViewIdentifier;
}
    
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    
    noteHeaderCollectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[noteHeaderCollectionView headerViewIdentifier] forIndexPath:indexPath];
    
    return headerView;
    
}

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
        
        [self addSubview:textLabel];
        self.noteLabelInHeader = textLabel;
    }
    return self;
}

@end
