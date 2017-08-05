//
//  drawPhoto.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "drawPhoto.h"

@implementation drawPhoto
//position有问题
- (UIImage *)drawPhotoWithWidth:(CGFloat)myWidth andHeight:(CGFloat)myHeight andPositionX:(CGFloat)myPositionX andPositionY:(CGFloat)myPositionY andColor:(UIColor *)myColor{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myWidth, myHeight), NO, 0);
    UIBezierPath *myPath = [UIBezierPath bezierPathWithRect:CGRectMake(myPositionX, myPositionY, myWidth, myHeight)];
    [myColor setFill];
    [myPath fill];
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}



@end
