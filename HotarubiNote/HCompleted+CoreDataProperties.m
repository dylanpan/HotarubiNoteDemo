//
//  HCompleted+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "HCompleted+CoreDataProperties.h"

@implementation HCompleted (CoreDataProperties)

+ (NSFetchRequest<HCompleted *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HCompleted"];
}

@dynamic participatorCompletedTime;
@dynamic participatorCompletedTitle;
@dynamic participatorContent;
@dynamic participatorContentPhoto;
@dynamic participatorId;
@dynamic participatorName;
@dynamic participatorPhoto;
@dynamic completedWhat;
@dynamic whoParticipate;

@end
