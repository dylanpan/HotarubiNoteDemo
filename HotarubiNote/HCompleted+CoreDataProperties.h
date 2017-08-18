//
//  HCompleted+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "HCompleted+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HCompleted (CoreDataProperties)

+ (NSFetchRequest<HCompleted *> *)fetchRequest;

@property (nonatomic) int32_t participatorCompletedTime;
@property (nullable, nonatomic, copy) NSString *participatorCompletedTitle;
@property (nullable, nonatomic, copy) NSString *participatorContent;
@property (nullable, nonatomic, retain) NSData *participatorContentPhoto;
@property (nullable, nonatomic, copy) NSString *participatorId;
@property (nullable, nonatomic, copy) NSString *participatorName;
@property (nullable, nonatomic, retain) NSData *participatorPhoto;
@property (nullable, nonatomic, retain) NSSet<HNote *> *completedWhat;
@property (nullable, nonatomic, retain) User *whoParticipate;

@end

@interface HCompleted (CoreDataGeneratedAccessors)

- (void)addCompletedWhatObject:(HNote *)value;
- (void)removeCompletedWhatObject:(HNote *)value;
- (void)addCompletedWhat:(NSSet<HNote *> *)values;
- (void)removeCompletedWhat:(NSSet<HNote *> *)values;

@end

NS_ASSUME_NONNULL_END
