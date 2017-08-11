//
//  Friend+CoreDataProperties.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//
//

#import "Friend+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Friend (CoreDataProperties)

+ (NSFetchRequest<Friend *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *friendGroupName;
@property (nonatomic) int32_t friendId;
@property (nullable, nonatomic, copy) NSString *friendManifesto;
@property (nullable, nonatomic, copy) NSString *friendName;
@property (nullable, nonatomic, retain) NSData *friendPhoto;
@property (nullable, nonatomic, copy) NSString *friendGroupDetail;

@end

NS_ASSUME_NONNULL_END
