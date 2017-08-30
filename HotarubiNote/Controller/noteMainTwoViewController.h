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
#import "editFriendInfoViewController.h"
#import "Friend+CoreDataClass.h"
#import "Friend+CoreDataProperties.h"
#import "coreDataManager.h"

@interface noteMainTwoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *noteFriendTableView;
@property (strong, nonatomic) UISearchController *noteFriendSearchController;
@property (strong, nonatomic) UIToolbar *noteFriendToolBar;
@property (copy, nonatomic) NSArray *noteFriendGroups;
@property (copy, nonatomic) NSArray *noteFriends;
@property (copy, nonatomic) NSArray *noteSearchFriends;
@property (nonatomic) BOOL isSearching;
@property (nonatomic, copy) NSMutableArray *sectionsArray;

//通过声明CoreData读取数据
@property (nonatomic, strong) NSManagedObjectContext *friendMOC;
//用来存储查询并适合TableView来显示的数据
@property (nonatomic, strong) NSFetchedResultsController *friendFRC;

@property (strong, nonatomic) Friend *noteFriend;

@end
