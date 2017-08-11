//
//  Note+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Note"];
}

@dynamic originatorColor;
@dynamic originatorContenPhoto;
@dynamic originatorContent;
@dynamic originatorLimitedTime;
@dynamic originatorLocation;
@dynamic originatorName;
@dynamic originatorPhoto;
@dynamic originatorStar;
@dynamic originatorSubtitle;
@dynamic originatorTitle;
@dynamic participatorCompletedTime;
@dynamic participatorContent;
@dynamic participatorContentPhoto;
@dynamic participatorName;
@dynamic participatorPhoto;
@dynamic originatorId;
@dynamic participatorId;
@dynamic originator;
@dynamic participator;

@end
