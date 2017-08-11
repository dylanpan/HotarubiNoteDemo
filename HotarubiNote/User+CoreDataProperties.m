//
//  User+CoreDataProperties.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/10.
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
@dynamic userName;
@dynamic userPassword;
@dynamic userPhoto;
@dynamic userId;
@dynamic userManifesto;
@dynamic originatorNote;
@dynamic participatorNote;

@end
