//
//  Note+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/8.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "Note+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *originatorName;
@property (nullable, nonatomic, copy) NSString *originatorPhoto;
@property (nullable, nonatomic, copy) NSString *originatorLocation;
@property (nullable, nonatomic, copy) NSString *originatorStar;
@property (nullable, nonatomic, copy) NSDate *originatorLimitedTime;
@property (nullable, nonatomic, copy) NSString *originatorColor;
@property (nullable, nonatomic, copy) NSString *originatorTitle;
@property (nullable, nonatomic, copy) NSString *originatorSubtitle;
@property (nullable, nonatomic, copy) NSString *originatorContent;
@property (nullable, nonatomic, copy) NSString *originatorContenPhoto;
@property (nullable, nonatomic, copy) NSString *participatorName;
@property (nullable, nonatomic, copy) NSString *participatorPhoto;
@property (nullable, nonatomic, copy) NSDate *participatorCompletedTime;
@property (nullable, nonatomic, copy) NSString *participatorContent;
@property (nullable, nonatomic, copy) NSString *participatorContentPhoto;
@property (nullable, nonatomic, retain) User *originator;
@property (nullable, nonatomic, retain) NSSet<User *> *participator;

@end

@interface Note (CoreDataGeneratedAccessors)

- (void)addParticipatorObject:(User *)value;
- (void)removeParticipatorObject:(User *)value;
- (void)addParticipator:(NSSet<User *> *)values;
- (void)removeParticipator:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
