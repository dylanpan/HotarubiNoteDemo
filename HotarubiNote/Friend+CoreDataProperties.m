//
//  Friend+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/14.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "Friend+CoreDataProperties.h"

@implementation Friend (CoreDataProperties)

+ (NSFetchRequest<Friend *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
}

@dynamic friendGroupDetail;
@dynamic friendGroupName;
@dynamic friendId;
@dynamic friendManifesto;
@dynamic friendName;
@dynamic friendPhoto;

@end
