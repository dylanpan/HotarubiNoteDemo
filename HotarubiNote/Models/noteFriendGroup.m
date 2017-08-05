//
//  noteFriendGroup.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteFriendGroup.h"

@implementation noteFriendGroup

- (noteFriendGroup *) initWithNoteFriendGroupName:(NSString *)noteFriendGroupName andNoteFriendGroupDetail:(NSString *)noteFriendGroupDetail andNoteFriends:(NSMutableArray *)noteFriends{
    if (self = [super init]) {
        self.noteFriendGroupName = noteFriendGroupName;
        self.noteFriendGroupDetail = noteFriendGroupDetail;
        self.noteFriends = noteFriends;
    }
    return self;
}

+ (noteFriendGroup *) initWithNoteFriendGroupName:(NSString *)noteFriendGroupName andNoteFriendGroupDetail:(NSString *)noteFriendGroupDetail andNoteFriends:(NSMutableArray *)noteFriends{
    noteFriendGroup *noteFriendGroupNew = [[noteFriendGroup alloc] initWithNoteFriendGroupName:noteFriendGroupName
                                                                      andNoteFriendGroupDetail:noteFriendGroupDetail
                                                                                andNoteFriends:noteFriends];
    return noteFriendGroupNew;
}

- (noteFriendGroup *) initWithDictionary:(NSDictionary *)noteFriendGroupDictionary{
    if (self = [super init]) {
        self.noteFriendGroupName = noteFriendGroupDictionary[@"noteFriendGroupName"];
        self.noteFriendGroupDetail = noteFriendGroupDictionary[@"noteFriendGroupDetail"];
        self.noteFriends = noteFriendGroupDictionary[@"noteFriends"];
    }
    return self;
}

+ (noteFriendGroup *) noteFriendGroupWithDictionary:(NSDictionary *)noteFriendGroupDictionary{
    noteFriendGroup *noteFriendGroupNew = [[noteFriendGroup alloc] initWithDictionary:noteFriendGroupDictionary];
    return noteFriendGroupNew;
}

@end
