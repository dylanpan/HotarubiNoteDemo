//
//  User+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/8.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nonatomic) BOOL isOriginte;
@property (nonatomic) BOOL isParticipate;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, retain) NSSet<Note *> *originatorNote;
@property (nullable, nonatomic, retain) NSSet<Note *> *participatorNote;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addOriginatorNoteObject:(Note *)value;
- (void)removeOriginatorNoteObject:(Note *)value;
- (void)addOriginatorNote:(NSSet<Note *> *)values;
- (void)removeOriginatorNote:(NSSet<Note *> *)values;

- (void)addParticipatorNoteObject:(Note *)value;
- (void)removeParticipatorNoteObject:(Note *)value;
- (void)addParticipatorNote:(NSSet<Note *> *)values;
- (void)removeParticipatorNote:(NSSet<Note *> *)values;

@end

NS_ASSUME_NONNULL_END
