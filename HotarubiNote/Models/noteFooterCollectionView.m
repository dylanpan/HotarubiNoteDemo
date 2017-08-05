//
//  noteFooterCollectionView.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/27.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteFooterCollectionView.h"

@implementation noteFooterCollectionView

+ (NSString *)footerViewIdentifier{
    
    static NSString *footerViewIdentifier = @"FooterViewIdentifier";
    return footerViewIdentifier;
}

+ (instancetype)footerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    
    noteFooterCollectionView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[noteFooterCollectionView footerViewIdentifier] forIndexPath:indexPath];
    
    return footerView;
    
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
        self.noteLabelInFooter = textLabel;
    }
    return self;
}

@end
