//
//  User+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic isOriginte;
@dynamic isParticipate;
@dynamic userId;
@dynamic userManifesto;
@dynamic userName;
@dynamic userPassword;
@dynamic userPhoto;
@dynamic orginator;
@dynamic participator;

@end
