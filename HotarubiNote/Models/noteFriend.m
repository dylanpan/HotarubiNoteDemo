//
//  noteFriend.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteFriend.h"

@implementation noteFriend

- (noteFriend *) initWithNoteUserName:(NSString *)noteUserName andNoteUserID:(NSString *)noteUserID andNoteUserManifesto:(NSString *)noteUserManifesto andNoteUserPhoto:(NSString *)noteUserPhoto{
    if (self = [super init]) {
        self.noteUserName = noteUserName;
        self.noteUserID = noteUserID;
        self.noteUserManifesto = noteUserManifesto;
        self.noteUserPhoto = noteUserPhoto;
    }
    return self;
}

+ (noteFriend *) initWithNoteUserName:(NSString *)noteUserName andNoteUserID:(NSString *)noteUserID andNoteUserManifesto:(NSString *)noteUserManifesto andNoteUserPhoto:(NSString *)noteUserPhoto{
    noteFriend *noteFriendNew = [[noteFriend alloc] initWithNoteUserName:noteUserName
                                                           andNoteUserID:noteUserID
                                                    andNoteUserManifesto:noteUserManifesto
                                                        andNoteUserPhoto:noteUserPhoto];
    return noteFriendNew;
}

- (noteFriend *) initWithDictionary:(NSDictionary *)noteFriendDictionary{
    if (self = [super init]) {
        self.noteUserName = noteFriendDictionary[@"noteUserName"];
        self.noteUserID = noteFriendDictionary[@"noteUserID"];
        self.noteUserManifesto = noteFriendDictionary[@"noteUserManifesto"];
        self.noteUserPhoto = noteFriendDictionary[@"noteUserPhoto"];
    }
    return self;
}

+ (noteFriend *) noteFriendWithDictionary:(NSDictionary *)noteFriendDictionary{
    noteFriend *noteFriendNew = [[noteFriend alloc] initWithDictionary:noteFriendDictionary];
    return noteFriendNew;
}


@end
