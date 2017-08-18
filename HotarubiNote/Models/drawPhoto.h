//
//  drawPhoto.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawPhoto : UIImage

- (UIImage *)drawPersonPhotoWithWidth:(CGFloat)myWidth height:(CGFloat)myHeight positionX:(CGFloat)myPositionX positionY:(CGFloat)myPositionY color:(UIColor *)myColor;
- (UIImage *)drawContentPhotoWithWidth:(CGFloat)myWidth height:(CGFloat)myHeight positionX:(CGFloat)myPositionX positionY:(CGFloat)myPositionY color:(UIColor *)myColor;



@end
