//
//  HNote+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "HNote+CoreDataProperties.h"

@implementation HNote (CoreDataProperties)

+ (NSFetchRequest<HNote *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HNote"];
}

@dynamic originatorColor;
@dynamic originatorContenPhoto;
@dynamic originatorContent;
@dynamic originatorId;
@dynamic originatorLimitedTime;
@dynamic originatorLocation;
@dynamic originatorName;
@dynamic originatorPhoto;
@dynamic originatorStar;
@dynamic originatorSubtitle;
@dynamic originatorTitle;
@dynamic whoCompleted;
@dynamic whoOriginate;

@end
