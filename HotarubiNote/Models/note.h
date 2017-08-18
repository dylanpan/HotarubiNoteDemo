//
//  note.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface note : NSObject

@property (nonatomic, assign) long long noteID;
@property (nonatomic, copy) NSString *noteTitle;
@property (nonatomic, copy) NSString *noteStar;
@property (nonatomic, copy) NSDate *noteTime;
@property (nonatomic, copy) NSString *noteContent;
@property (nonatomic, copy) NSString *noteAuthor;
@property (nonatomic, copy) NSString *noteAuthorPhoto;
@property (nonatomic, copy) NSString *noteMainPhoto;

- (note *) initWithDictionary:(NSDictionary *)noteDictionary;

+ (note *) noteWithDictionary:(NSDictionary *)noteDictionary;


@end
