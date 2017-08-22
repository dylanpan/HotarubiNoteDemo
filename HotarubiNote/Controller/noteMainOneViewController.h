//
//  noteMainOneViewController.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "note.h"
#import "noteTableViewCell.h"
#import "HNote+CoreDataClass.h"
#import "HNote+CoreDataProperties.h"
#import "editNoteInfoViewController.h"
#import "coreDataManager.h"

@interface noteMainOneViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *noteMainTableView;
@property (strong, nonatomic) UIToolbar *noteMainToolBar;
@property (strong, nonatomic) UISearchBar *noteSearchBar;
@property (strong, nonatomic) UIRefreshControl *noteRefreshDataControl;
@property (nonatomic) BOOL isSearching;
@property (copy, nonatomic) NSMutableArray *notes;
@property (copy, nonatomic) NSMutableDictionary *notesHeight;

//通过声明CoreData读取数据
@property (nonatomic, strong) NSManagedObjectContext *hnoteMOC;
//用来存储查询并适合TableView来显示的数据
@property (nonatomic, strong) NSFetchedResultsController *hnoteFRC;

@property (nonatomic, strong) HNote *hnote;

@end
