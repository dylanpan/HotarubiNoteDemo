//
//  User+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nonatomic) BOOL isOriginte;
@property (nonatomic) BOOL isParticipate;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, copy) NSString *userManifesto;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *userPassword;
@property (nullable, nonatomic, retain) NSData *userPhoto;
@property (nullable, nonatomic, retain) NSSet<HNote *> *orginator;
@property (nullable, nonatomic, retain) NSSet<HCompleted *> *participator;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addOrginatorObject:(HNote *)value;
- (void)removeOrginatorObject:(HNote *)value;
- (void)addOrginator:(NSSet<HNote *> *)values;
- (void)removeOrginator:(NSSet<HNote *> *)values;

- (void)addParticipatorObject:(HCompleted *)value;
- (void)removeParticipatorObject:(HCompleted *)value;
- (void)addParticipator:(NSSet<HCompleted *> *)values;
- (void)removeParticipator:(NSSet<HCompleted *> *)values;

@end

NS_ASSUME_NONNULL_END
