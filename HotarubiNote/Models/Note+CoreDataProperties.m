//
//  Note+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/8.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Note"];
}

@dynamic originatorName;
@dynamic originatorPhoto;
@dynamic originatorLocation;
@dynamic originatorStar;
@dynamic originatorLimitedTime;
@dynamic originatorColor;
@dynamic originatorTitle;
@dynamic originatorSubtitle;
@dynamic originatorContent;
@dynamic originatorContenPhoto;
@dynamic participatorName;
@dynamic participatorPhoto;
@dynamic participatorCompletedTime;
@dynamic participatorContent;
@dynamic participatorContentPhoto;
@dynamic originator;
@dynamic participator;

@end
