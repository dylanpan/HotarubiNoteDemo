//
//  noteFriend.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface noteFriend : NSObject

@property (copy, nonatomic) NSString *noteUserName;
@property (copy, nonatomic) NSString *noteUserID;
@property (copy, nonatomic) NSString *noteUserManifesto;
@property (copy, nonatomic) NSString *noteUserPhoto;

//构造函数
- (noteFriend *) initWithNoteUserName:(NSString *)noteUserName andNoteUserID:(NSString *)noteUserID andNoteUserManifesto:(NSString *)noteUserManifesto;

//初始化方法
+ (noteFriend *) initWithNoteUserName:(NSString *)noteUserName andNoteUserID:(NSString *)noteUserID andNoteUserManifesto:(NSString *)noteUserManifesto;

- (noteFriend *) initWithDictionary:(NSDictionary *)noteFriendDictionary;

+ (noteFriend *) noteFriendWithDictionary:(NSDictionary *)noteFriendDictionary;

@end
