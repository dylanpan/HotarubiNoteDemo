//
//  note.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "note.h"

@implementation note

- (note *) initWithDictionary:(NSDictionary *)noteDictionary{
    if (self = [super init]) {
        self.noteID = [noteDictionary[@"noteID"] longLongValue];
        self.noteTitle = noteDictionary[@"noteTitle"];
        self.noteStar = noteDictionary[@"noteStar"];
        self.noteTime = noteDictionary[@"noteTime"];
        self.noteContent = noteDictionary[@"noteContent"];
        self.noteAuthor = noteDictionary[@"noteAuthor"];
        self.noteAuthorPhoto = noteDictionary[@"noteAuthorPhoto"];
        self.noteMainPhoto = noteDictionary[@"noteMainPhoto"];
    }
    return self;
}

+ (note *) noteWithDictionary:(NSDictionary *)noteDictionary{
    note *myNote = [[note alloc] initWithDictionary:noteDictionary];
    return myNote;
}




@end
