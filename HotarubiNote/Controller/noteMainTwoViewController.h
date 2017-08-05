//
//  noteMainTwoViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "noteFriend.h"
#import "noteFriendGroup.h"
#import "drawPhoto.h"

@interface noteMainTwoViewController : UIViewController <UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *noteFriendTableView;
@property (strong, nonatomic) UISearchBar *noteFriendSearchBar;
@property (strong, nonatomic) NSMutableArray *noteFriendGroups;
@property (strong, nonatomic) NSMutableArray *noteFriends;
@property (strong, nonatomic) NSMutableArray *noteSearchFriends;
@property (nonatomic) BOOL  isSearching;

@end
