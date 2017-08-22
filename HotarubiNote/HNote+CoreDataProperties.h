//
//  HNote+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/19.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "HNote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HNote (CoreDataProperties)

+ (NSFetchRequest<HNote *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *originatorColor;
@property (nullable, nonatomic, retain) NSData *originatorContenPhoto;
@property (nullable, nonatomic, copy) NSString *originatorContent;
@property (nonatomic) int32_t originatorId;
@property (nullable, nonatomic, copy) NSDate *originatorLimitedTime;
@property (nullable, nonatomic, copy) NSString *originatorLocation;
@property (nullable, nonatomic, copy) NSString *originatorName;
@property (nullable, nonatomic, retain) NSData *originatorPhoto;
@property (nullable, nonatomic, copy) NSString *originatorStar;
@property (nullable, nonatomic, copy) NSString *originatorSubtitle;
@property (nullable, nonatomic, copy) NSString *originatorTitle;
@property (nonatomic) float originatorNoteHeight;
@property (nullable, nonatomic, retain) NSSet<HCompleted *> *whoCompleted;
@property (nullable, nonatomic, retain) User *whoOriginate;

@end

@interface HNote (CoreDataGeneratedAccessors)

- (void)addWhoCompletedObject:(HCompleted *)value;
- (void)removeWhoCompletedObject:(HCompleted *)value;
- (void)addWhoCompleted:(NSSet<HCompleted *> *)values;
- (void)removeWhoCompleted:(NSSet<HCompleted *> *)values;

@end

NS_ASSUME_NONNULL_END
