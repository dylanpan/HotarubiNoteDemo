//
//  User+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/8.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic name;
@dynamic password;
@dynamic photo;
@dynamic isOriginte;
@dynamic isParticipate;
@dynamic originatorNote;
@dynamic participatorNote;

@end
