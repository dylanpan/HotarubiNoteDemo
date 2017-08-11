//
//  noteMainTwoViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "noteFriend.h"
#import "noteFriendGroup.h"
#import "drawPhoto.h"
#import "Friend+CoreDataClass.h"
#import "Friend+CoreDataProperties.h"

@interface noteMainTwoViewController : UIViewController <UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *noteFriendTableView;
@property (strong, nonatomic) UISearchController *noteFriendSearchContrller;
@property (strong, nonatomic) UIToolbar *noteFriendToolBar;
@property (strong, nonatomic) NSMutableArray *noteFriendGroups;
@property (strong, nonatomic) NSMutableArray *noteFriends;
@property (strong, nonatomic) NSMutableArray *noteSearchFriends;
@property (nonatomic) BOOL isSearching;

//通过声明CoreData读取数据
@property (nonatomic, strong) NSManagedObjectContext *friendMOC;
//用来存储查询并适合TableView来显示的数据
@property (nonatomic, strong) NSFetchedResultsController *friendFRC;

@end
