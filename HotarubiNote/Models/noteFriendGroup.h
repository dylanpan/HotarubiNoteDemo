//
//  noteFriendGroup.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface noteFriendGroup : NSObject

@property (copy, nonatomic) NSString *noteFriendGroupName;
@property (copy, nonatomic) NSString *noteFriendGroupDetail;
@property (strong, nonatomic) NSMutableArray *noteFriends;

- (noteFriendGroup *) initWithNoteFriendGroupName:(NSString *)noteFriendGroupName andNoteFriendGroupDetail:(NSString *)noteFriendGroupDetail andNoteFriends:(NSMutableArray *)noteFriends;

+ (noteFriendGroup *) initWithNoteFriendGroupName:(NSString *)noteFriendGroupName andNoteFriendGroupDetail:(NSString *)noteFriendGroupDetail andNoteFriends:(NSMutableArray *)noteFriends;

- (noteFriendGroup *) initWithDictionary:(NSDictionary *)noteFriendGroupDictionary;

+ (noteFriendGroup *) noteFriendGroupWithDictionary:(NSDictionary *)noteFriendGroupDictionary;

@end
