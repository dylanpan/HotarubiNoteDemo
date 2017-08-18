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
- (UIImage *)drawPersonPhotoWithWidth:(CGFloat)myWidth height:(CGFloat)myHeight positionX:(CGFloat)myPositionX positionY:(CGFloat)myPositionY color:(UIColor *)myColor{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myWidth, myHeight), NO, 0);
    
    //中心圆
    CGFloat radius = myWidth / 10.0;
    CGFloat startAngle = 0.0;
    CGFloat endAngle = (CGFloat)(M_PI * 2);
    UIBezierPath *myCyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(myWidth/2.0, myHeight/2.0) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [myColor setFill];
    [myCyclePath fill];
    
    //下三角
    UIBezierPath *myDownTrianglePath = [UIBezierPath bezierPath];
    [myDownTrianglePath moveToPoint:CGPointMake(myWidth/2.0, myHeight/2.0)];
    [myDownTrianglePath addLineToPoint:CGPointMake(myWidth*3.0/4.0, myHeight)];
    [myDownTrianglePath addLineToPoint:CGPointMake(myWidth/4.0, myHeight)];
    [myDownTrianglePath closePath];
    [myColor setFill];
    [myDownTrianglePath fill];
    
    //上三角
    UIBezierPath *myUpTrianglePath = [UIBezierPath bezierPath];
    [myUpTrianglePath moveToPoint:CGPointMake(myWidth/2.0, myHeight/2.0)];
    [myUpTrianglePath addLineToPoint:CGPointMake(myWidth*3.0/4.0, 0.0)];
    [myUpTrianglePath addLineToPoint:CGPointMake(myWidth/4.0, 0.0)];
    [myUpTrianglePath closePath];
    [myColor setFill];
    [myUpTrianglePath fill];
    
    //左三角
    UIBezierPath *myLeftTrianglePath = [UIBezierPath bezierPath];
    [myLeftTrianglePath moveToPoint:CGPointMake(myWidth/2.0, myHeight/2.0)];
    [myLeftTrianglePath addLineToPoint:CGPointMake(0.0, myHeight*3.0/4.0)];
    [myLeftTrianglePath addLineToPoint:CGPointMake(0.0, myHeight/4.0)];
    [myLeftTrianglePath closePath];
    [myColor setFill];
    [myLeftTrianglePath fill];
    
    //右三角
    UIBezierPath *myRightTrianglePath = [UIBezierPath bezierPath];
    [myRightTrianglePath moveToPoint:CGPointMake(myWidth/2.0, myHeight/2.0)];
    [myRightTrianglePath addLineToPoint:CGPointMake(myWidth, myHeight*3.0/4.0)];
    [myRightTrianglePath addLineToPoint:CGPointMake(myWidth, myHeight/4.0)];
    [myRightTrianglePath closePath];
    [myColor setFill];
    [myRightTrianglePath fill];
    
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

- (UIImage *)drawContentPhotoWithWidth:(CGFloat)myWidth height:(CGFloat)myHeight positionX:(CGFloat)myPositionX positionY:(CGFloat)myPositionY color:(UIColor *)myColor{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myWidth, myHeight), NO, 0);
    
    UIBezierPath *myPath = [UIBezierPath bezierPathWithRect:CGRectMake(myPositionX, myPositionY, myWidth, myHeight)];
    [myColor setFill];
    [myPath fill];
    
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}


- (void) scaleImageWith:(CGSize)size completion:(void(^)(UIImage *))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        [self drawInRect:rect];
        UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(scaleImage);
            }
        });
    });
}

@end
