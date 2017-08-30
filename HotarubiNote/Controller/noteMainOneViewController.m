//
//  noteMainOneViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainOneViewController.h"

#define noteMainToolBarHeight 44.0
#define noteSearchBarHeight 44.0

@interface noteMainOneViewController ()
//@property (strong, nonatomic) HotarubiNoteViewController *hotarubiNoteViewController;
@end

@implementation noteMainOneViewController
@synthesize hnoteMOC = _hnoteMOC;
//@synthesize hotarubiNoteViewController = _hotarubiNoteViewController;

- (NSManagedObjectContext *) hnoteMOC{
    if (!_hnoteMOC) {
        _hnoteMOC = [coreDataManager shareCoreDataManager].managedObjectContext;
    }
    return _hnoteMOC;
}

//- (HotarubiNoteViewController *) hotarubiNoteViewController{
//    if (!_hotarubiNoteViewController) {
//        _hotarubiNoteViewController = (HotarubiNoteViewController *)self.hotarubiNoteViewController;
//    }
//    return _hotarubiNoteViewController;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self addToolBar];
    [self loadData];
    [self refreshData];
    
    NSLog(@"login user name:%@",self.loginUserName);
    
//    _hotarubiNoteViewController.loginUserBlock = ^(NSString *name) {
//        NSLog(@"login user name in block:%@",name);
//    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initTableView{
    CGRect noteMainTableViewRect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.noteMainTableView = [[UITableView alloc] initWithFrame:noteMainTableViewRect style:UITableViewStylePlain];
    self.noteMainTableView.dataSource = self;
    self.noteMainTableView.delegate = self;
    
    [self.view addSubview:self.noteMainTableView];
    self.isSearching = NO;
    
    //需要通过代码设置Autolayout（1.禁用autoresizing；2.创建约束；3.添加约束）
    
    //禁用父视图autoresizing对子视图无效
    self.noteMainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    /*
     constraintWithItem:需要设置约束的view
     attribute:需要设置约束的位置
     relatedBy:约束的条件
     toItem:约束依赖目标
     attribute:依赖目标约束位置
     multiplier:配置系数
     constant:额外需要添加的长度
     */
    /*
     计算公式：tableview.attribute = self.view.attribute * multiplier + constant
     */
    /*
     公式中=符号取决于relatedBy参数
     NSLayoutRelationEqual:等于
     NSLayoutRelationLessThanOrEqual:小于等于
     NSLayoutRelationGreaterThanOrEqual:大于等于
     */
    /**/
    //创建约束对象(顶部)
    NSLayoutConstraint *tableViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64];
    //添加约束对象
    [self.view addConstraint:tableViewTopConstraint];
    
    //创建约束对象(左边)
    NSLayoutConstraint *tableViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:tableViewLeftConstraint];
    
    //创建约束对象(右边)
    NSLayoutConstraint *tableViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:tableViewRightConstraint];
    
    //创建约束对象(底部)
    NSLayoutConstraint *tableViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:tableViewBottomConstraint];
    
}

- (void) loadData{
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    //NSLog(@"context:%@",myCoreDataManager.managedObjectContext);
    //抓取请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"HNote"];
    fetchRequest.predicate = nil;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"originatorTitle" ascending:YES];
    fetchRequest.sortDescriptors = @[sort];
    
    self.hnoteFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                         managedObjectContext:myCoreDataManager.managedObjectContext
                                                           sectionNameKeyPath:@"originatorTitle"
                                                                    cacheName:nil];
    self.hnoteFRC.delegate = self;
    NSError *error = nil;
    [self.hnoteFRC performFetch:&error];
}

- (void) addToolBar{
    self.noteMainToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteMainToolBarHeight)];
    [self.view addSubview:self.noteMainToolBar];
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeNote)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *initButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(initData)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:@selector(searchNote)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote)];
    NSArray *buttonArray = [NSArray arrayWithObjects:removeButton, flexibleButton, initButton, searchButton, addButton, nil];
    self.noteMainToolBar.items = buttonArray;
    
    self.noteMainToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    //创建约束对象(顶部)
    NSLayoutConstraint *toolBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainToolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    //添加约束对象
    [self.view addConstraint:toolBarTopConstraint];
    
    //创建约束对象(左边)
    NSLayoutConstraint *toolBarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainToolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarLeftConstraint];
    
    //创建约束对象(右边)
    NSLayoutConstraint *toolBarRightConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainToolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarRightConstraint];
    
    //创建约束对象(高度)
    NSLayoutConstraint *toolBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.noteMainToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:noteMainToolBarHeight];
    //添加约束对象
    [self.noteMainToolBar addConstraint:toolBarHeightConstraint];
    
}

- (void) removeNote{
    [self.noteMainTableView setEditing:!self.noteMainTableView.isEditing animated:YES];
}

- (void) addNote{
    //使用storyboard中的identifierID获取destination view controller
    //获取storyboard的实例
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取目标viewController的实例，必须在storyboard的右侧标明【storyboard ID】
    editNoteInfoViewController *addNoteController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addNoteController"];
    
    [self presentViewController:addNoteController animated:YES completion:nil];
}

- (void) initData{
    NSString *initOneNotePath = [[NSBundle mainBundle] pathForResource:@"noteMain" ofType:@"plist"];
    NSArray *initOneNoteArray = [NSArray arrayWithContentsOfFile:initOneNotePath];
    NSMutableArray *initNoteArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *initNoteHeightDict = [[NSMutableDictionary alloc] init];
    [initOneNoteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [initNoteArray addObject:[note noteWithDictionary:obj]];
    }];
    
    self.notes = initNoteArray;
    
    for (note *eachNote in self.notes) {
        HNote *hnote = [NSEntityDescription insertNewObjectForEntityForName:@"HNote" inManagedObjectContext:self.hnoteMOC];
        hnote.originatorTitle = eachNote.noteTitle;
        hnote.originatorStar = eachNote.noteStar;
        hnote.originatorContent = eachNote.noteContent;
        hnote.originatorName = eachNote.noteAuthor;
        hnote.originatorLimitedTime = eachNote.noteTime;
        
        noteTableViewCell *cellHeight = [[noteTableViewCell alloc] init];
        cellHeight.oneNote = eachNote;
        [initNoteHeightDict setValue:@(cellHeight.oneNoteHeight) forKey:cellHeight.oneNoteHeightKey];
    }
    
    self.notesHeight = initNoteHeightDict;
    
    NSError *error = nil;
    if (self.hnoteMOC.hasChanges) {
        [self.hnoteMOC save:&error];
    }
    if (error) {
        NSLog(@"core data insert init data error : %@",error);
    }
    
    NSLog(@"noteMainViewController.m\nview init data");
    
}

- (void) searchNote{
    if (self.isSearching) {
        self.isSearching = NO;
        //处于搜索状态，可以搜索，不可刷新
        [self.noteSearchBar removeFromSuperview];
        [self refreshData];
        [self.noteMainTableView reloadData];
    }else{
        //不处于搜索状态，不可搜索框，可以刷新
        self.isSearching = YES;
        [self addSearchBar];
        [self.noteRefreshDataControl removeFromSuperview];
    }
}

- (void) addSearchBar{
    UISearchBar *mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.frame.size.width, noteSearchBarHeight)];
    mySearchBar.placeholder = @"Search by title";
    mySearchBar.barStyle = UIBarStyleDefault;
    mySearchBar.showsCancelButton = NO;
    mySearchBar.delegate = self;
    [mySearchBar sizeToFit];
    //[self.noteMainTableView setTableHeaderView:mySearchBar];
    [self.view addSubview:mySearchBar];
    self.noteSearchBar = mySearchBar;
}

- (void) refreshData{
    UIRefreshControl *refreshDataControl = [[UIRefreshControl alloc] init];
    [refreshDataControl addTarget:self action:@selector(refreshNote:) forControlEvents:UIControlEventValueChanged];
    [self.noteMainTableView addSubview:refreshDataControl];
    [refreshDataControl beginRefreshing];
    [self refreshNote:refreshDataControl];
    self.noteRefreshDataControl = refreshDataControl;
}

- (void) refreshNote:(UIRefreshControl *)refreshControl{
    [self loadData];
    [refreshControl endRefreshing];
    [self.noteMainTableView reloadData];
}

#pragma mark - data source method
//返回分组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *eachNoteGroups = [self.hnoteFRC sections];
    //NSLog(@"table view section:%lu",(unsigned long)eachNoteGroups.count);
    return eachNoteGroups.count;
}

//返回每组行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *eachNoteGroups = [self.hnoteFRC sections];
    id<NSFetchedResultsSectionInfo> eachGruop = eachNoteGroups[section];
    //NSLog(@"section %ld has row:%lu",(long)section,(unsigned long)[eachGruop numberOfObjects]);
    return [eachGruop numberOfObjects];
}

//返回每一行的单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKeyHNote";
    noteTableViewCell *eachNoteCell;
    static NSString *cellIdentifierBySearch = @"UITableViewCellIdentifierKeyBySearch";
    noteTableViewCell *eachNoteCellBySearch;
    if (self.isSearching) {
        eachNoteCellBySearch = [tableView dequeueReusableCellWithIdentifier:cellIdentifierBySearch];
        if (!eachNoteCellBySearch) {
            eachNoteCellBySearch = [[noteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifierBySearch];
        }
        HNote *hnote = [self.hnoteFRC objectAtIndexPath:indexPath];
        note *eachNote = [self noteFromEntity:hnote];
        
        eachNoteCellBySearch.oneNote = eachNote;
        
        if (hnote.originatorContenPhoto != nil) {
            eachNoteCellBySearch.noteCellMainPhoto.image = [UIImage imageWithData:hnote.originatorContenPhoto];
        }
        if (hnote.originatorPhoto != nil) {
            eachNoteCellBySearch.noteCellAuthorPhoto.image = [UIImage imageWithData:hnote.originatorPhoto];
        }
        return eachNoteCellBySearch;
    }else{
        eachNoteCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!eachNoteCell) {
            eachNoteCell = [[noteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        HNote *hnote = [self.hnoteFRC objectAtIndexPath:indexPath];
        note *eachNote = [self noteFromEntity:hnote];
        
        eachNoteCell.oneNote = eachNote;
        
        if (hnote.originatorContenPhoto != nil) {
            eachNoteCell.noteCellMainPhoto.image = [UIImage imageWithData:hnote.originatorContenPhoto];
        }
        
        if (hnote.originatorPhoto != nil) {
            eachNoteCell.noteCellAuthorPhoto.image = [UIImage imageWithData:hnote.originatorPhoto];
        }
        __weak noteMainOneViewController *weakSelf = self;
        eachNoteCell.transformViewBlock = ^(NSString *string) {
            NSLog(@"block:%@",string);
            [weakSelf transformPersonalView:hnote];
        };
        return eachNoteCell;
    }
}

-  (note *) noteFromEntity:(HNote *)hnote{
    note *myNote = [[note alloc] init];
    myNote.noteTitle = hnote.originatorTitle;
    myNote.noteTime = hnote.originatorLimitedTime;
    myNote.noteStar = hnote.originatorSubtitle;
    myNote.noteAuthor = hnote.originatorName;
    myNote.noteContent = hnote.originatorContent;
    return myNote;
}


#pragma mark - table view delegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //不加此句，二级目录返回时处于选取状态；加上此句，二级目录返回时处于非选取状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取storyboard的实例
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取目标viewController的实例，必须在storyboard的右侧标明【storyboard ID】
    editNoteInfoViewController *addNoteController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addNoteController"];
    
    HNote *selectHNote = [self.hnoteFRC objectAtIndexPath:indexPath];
    [addNoteController setValue:selectHNote forKey:@"hnote"];
    
    [self presentViewController:addNoteController animated:YES completion:nil];
    
}

//点击头像，页面跳转
- (void) transformPersonalView:(HNote *)hnote{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    personalSettingViewController *personalSettingViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"personalSettingViewController"];
    NSLog(@"call present method");
    [personalSettingViewController setValue:hnote forKey:@"hnote"];
    [self presentViewController:personalSettingViewController animated:YES completion:nil];
}

//重新设置cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKeyHNote";
    noteTableViewCell *eachNoteCell;
    static NSString *cellIdentifierBySearch = @"UITableViewCellIdentifierKeyBySearch";
    noteTableViewCell *eachNoteCellBySearch;
    if (self.isSearching) {
        eachNoteCellBySearch = [tableView dequeueReusableCellWithIdentifier:cellIdentifierBySearch];
        if (!eachNoteCellBySearch) {
            eachNoteCellBySearch = [[noteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifierBySearch];
        }
        HNote *hnote = [self.hnoteFRC objectAtIndexPath:indexPath];
        note *eachNote = [self noteFromEntity:hnote];
        
        eachNoteCellBySearch.oneNote = eachNote;
        
        CGFloat height = [[self.notesHeight valueForKey:eachNoteCellBySearch.oneNoteHeightKey] floatValue];
        //NSLog(@"cell height key : %@\ncell height : %f",eachNoteCellBySearch.oneNoteHeightKey,height);
        if (height) {
            return height;
        }
        [self.notesHeight setValue:@(eachNoteCellBySearch.oneNoteHeight) forKey:eachNoteCellBySearch.oneNoteHeightKey];
        //NSLog(@"\nsearch title : %@\nsection : %ld\nrow : %ld\ncell by search height key : %@\ncell by search height : %f",eachNote.noteTitle,(long)indexPath.section,(long)indexPath.row,eachNoteCellBySearch.oneNoteHeightKey,eachNoteCellBySearch.oneNoteHeight);
        return eachNoteCellBySearch.oneNoteHeight;
    }else{
        eachNoteCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!eachNoteCell) {
            eachNoteCell = [[noteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        HNote *hnote = [self.hnoteFRC objectAtIndexPath:indexPath];
        note *eachNote = [self noteFromEntity:hnote];
        
        eachNoteCell.oneNote = eachNote;
        
        CGFloat height = [[self.notesHeight valueForKey:eachNoteCell.oneNoteHeightKey] floatValue];
        //NSLog(@"cell height key : %@\ncell height : %f",eachNoteCell.oneNoteHeightKey,height);
        if (height) {
            return height;
        }
        [self.notesHeight setValue:@(eachNoteCell.oneNoteHeight) forKey:eachNoteCell.oneNoteHeightKey];
        //NSLog(@"\ntitle : %@\nsection : %ld\nrow : %ld\ncell height key : %@\ncell height : %f",eachNote.noteTitle,(long)indexPath.section,(long)indexPath.row,eachNoteCell.oneNoteHeightKey,eachNoteCell.oneNoteHeight);
        return eachNoteCell.oneNoteHeight;
    }
    
    
}

#pragma mark - table view other method
//开启编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearching) {
        return NO;
    }else{
        return YES;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //通过CoreData删除对象
        //通过indexpath获取需要删除的实体
        HNote *deleteHNote = [self.hnoteFRC objectAtIndexPath:indexPath];
        
        //通过上下文删除实体
        [self.hnoteMOC deleteObject:deleteHNote];
        //NSLog(@"\ndelete title:%@\nsection:%ld row:%ld",deleteHNote.originatorTitle,(long)indexPath.section,(long)indexPath.row);
        //通过上下文进行保存操作，并进行错误处理
        NSError *error = nil;
        if (![self.hnoteMOC save:&error]) {
            NSLog(@"noteMainViewController.m\ndelete Table View Data error : %@",error);
        }
    }
}

////右侧出现排序按钮
//- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    //通过CoreData删除对象
//    //通过indexpath获取需要删除的实体
//    HNote *deleteHNote = [self.hnoteFRC objectAtIndexPath:sourceIndexPath];
//    //通过上下文删除实体
//    [self.hnoteMOC deleteObject:deleteHNote];
//    //通过indexpath获取需要添加的实体
//    HNote *insertHNote = [self.hnoteFRC objectAtIndexPath:destinationIndexPath];
//    //通过上下文添加实体
//    [self.hnoteMOC insertObject:insertHNote];
//    //通过上下文进行保存操作，并进行错误处理
//    NSError *error = nil;
//    if (![self.hnoteMOC save:&error]) {
//        NSLog(@"noteMainViewController.m\ndelete Table View Data error : %@",error);
//    }
//}


#pragma mark - add note view controller
//选取cell后触发，跳转到修改值的界面（与新增界面共用一个）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //判断sender是否为tableviewcell的对象
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        //做一个类型转换
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        
        //通过tableview获取cell对应的索引，然后通过索引获取对应的实例对象
        NSIndexPath *selectCellIndexPath = [self.noteMainTableView indexPathForCell:selectCell];
        
        //用FetchedResultsController通过indexpath获取实例
        HNote *selectHNote = [self.hnoteFRC objectAtIndexPath:selectCellIndexPath];
        
        //获取目标视图
        UIViewController *destinationViewController = [segue destinationViewController];
        
        //通过KVC传递参数
        [destinationViewController setValue:selectHNote forKey:@"hnote"];
    }else{
        NSLog(@"sender is %@",sender);
    }
}


#pragma mark - fetched results controller delegate
//当CoreData的数据正在发生变化的时候，FRC产生的回调
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.noteMainTableView beginUpdates];
}

//分区改变状况（section数据源发生改变）
- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.noteMainTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.noteMainTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

//数据改变状况（cell数据源发生改变）
- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.noteMainTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.noteMainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.noteMainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.noteMainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.noteMainTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

//当CoreData的数据完成改变时，FRC产生的回调
- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.noteMainTableView endUpdates];
}


#pragma mark - search bar delegate
//点击虚拟键盘上的搜索按钮
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (!self.isSearching) {
        self.isSearching = YES;
        [self.noteMainTableView reloadData];
    }
    [self.noteSearchBar resignFirstResponder];
}

//取消搜索
//- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    self.isSearching = NO;
//    self.noteSearchBar.text = @"";
//    [self.noteSearchBar resignFirstResponder];
//    [self.noteMainTableView reloadData];
//}

//输入搜索关键字
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.isSearching = YES;
    [self.noteMainTableView reloadData];
}

//搜索形成的新数据
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //新建查询语句
    NSFetchRequest *searchRequest = [[NSFetchRequest alloc] initWithEntityName:@"HNote"];
    
    //排序规则
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"originatorTitle" ascending:YES];
    searchRequest.sortDescriptors = @[sortDescriptor];
    
    //添加谓语
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"originatorTitle contains %@",searchBar.text];
    searchRequest.predicate = searchPredicate;
    
    //把查询结果存入FetchedResultsController中
    self.hnoteFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:searchRequest
                                                        managedObjectContext:self.hnoteMOC
                                                          sectionNameKeyPath:@"originatorTitle"
                                                                   cacheName:nil];
    
    //执行FetchedResultsController，并处理错误
    NSError *error = nil;
    if (![self.hnoteFRC performFetch:&error]) {
        NSLog(@"noteMainTwoViewController.m\nFetched search Data error : %@",error);
    }
    
    [self.noteMainTableView reloadData];
}

#pragma mark - keyboard exit
//点击view的空白处后触发，隐藏键盘
- (IBAction)View_TouchDown:(id)sender{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

#pragma mark - set status bar
- (BOOL) prefersStatusBarHidden{
    return NO;
}





@end
