//
//  noteMainTwoViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainTwoViewController.h"

#define noteFriendSearchBarHeight 44
#define noteFriendToolBarHeight 44

@interface noteMainTwoViewController ()

@end

@implementation noteMainTwoViewController
@synthesize friendMOC = _friendMOC;

- (NSManagedObjectContext *)friendMOC{
    if (!_friendMOC) {
        _friendMOC = [coreDataManager shareCoreDataManager].managedObjectContext;
    }
    return _friendMOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self addToolBar];
    
    [self loadData];
    
    NSLog(@"noteMainTwoViewController.m\nview did load");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initTableView{
    //创建一个分组样式的table view
    CGRect noteMainTwoTableViewRect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.noteFriendTableView = [[UITableView alloc] initWithFrame:noteMainTwoTableViewRect style:UITableViewStyleGrouped];
    
    self.noteFriendTableView.dataSource = self;
    self.noteFriendTableView.delegate = self;
    
    [self.view addSubview:self.noteFriendTableView];
}

- (void) loadData{
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    NSLog(@"context:%@",myCoreDataManager.managedObjectContext);
    //抓取请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    fetchRequest.predicate = nil;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"friendGroupName" ascending:YES];
    fetchRequest.sortDescriptors = @[sort];
    
    self.friendFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                         managedObjectContext:myCoreDataManager.managedObjectContext
                                                           sectionNameKeyPath:@"friendGroupName"
                                                                    cacheName:nil];
    self.friendFRC.delegate = self;
    NSError *error = nil;
    [self.friendFRC performFetch:&error];
    self.isSearching = NO;
}

- (void) addToolBar{
    self.noteFriendToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteFriendToolBarHeight)];
    [self.view addSubview:self.noteFriendToolBar];
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeFriend)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *initButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(initData)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:@selector(searchFriend)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    NSArray *buttonArray = [NSArray arrayWithObjects:removeButton, flexibleButton, initButton, searchButton, addButton, nil];
    self.noteFriendToolBar.items = buttonArray;
}

- (void) removeFriend{
    [self.noteFriendTableView setEditing:!self.noteFriendTableView.isEditing animated:YES];
    
}

- (void) addFriend{
    //使用storyboard中的identifierID获取destination view controller
    //获取storyboard的实例
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取目标viewController的实例，必须在storyboard的右侧标明【storyboard ID】
    editFriendInfoViewController *addFriendController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addFriendController"];
    
    [self presentViewController:addFriendController animated:YES completion:nil];
    
}

- (void) searchFriend{
    if (self.isSearching) {
        self.isSearching = NO;
        [self.noteFriendSearchController.searchBar removeFromSuperview];
        [self.noteFriendSearchController removeFromParentViewController];//mei you shanchu uisearchcontroller
        [self loadData];
        [self.noteFriendTableView reloadData];
    }else{
        self.isSearching = YES;
        [self addSearchBar];
    }
    
}

- (void) initData{
    NSString *initNoteFriendsDataPath = [[NSBundle mainBundle] pathForResource:@"noteFriends" ofType:@"plist"];
    NSArray *initNoteFriendsDataArray = [NSArray arrayWithContentsOfFile:initNoteFriendsDataPath];
    NSMutableArray *initFriendArray = [[NSMutableArray alloc] init];
    [initNoteFriendsDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [initFriendArray addObject:[noteFriend noteFriendWithDictionary:obj]];
    }];
    
    NSString *initNoteFriendGroupsDataPath = [[NSBundle mainBundle] pathForResource:@"noteFriendGroups" ofType:@"plist"];
    NSArray *initNoteFriendGroupsDataArray = [NSArray arrayWithContentsOfFile:initNoteFriendGroupsDataPath];
    NSMutableArray *initFriendGroupArray = [[NSMutableArray alloc] init];
    [initNoteFriendGroupsDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [initFriendGroupArray addObject:[noteFriendGroup noteFriendGroupWithDictionary:obj]];
    }];
    self.noteFriends = initFriendArray;
    self.noteFriendGroups = initFriendGroupArray;
    
    
    for (noteFriendGroup *eachGroup in self.noteFriendGroups) {
        NSArray *nameInGroup = eachGroup.noteFriends;
        for (NSString *name in nameInGroup) {
            Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.friendMOC];
            friend.friendGroupName = eachGroup.noteFriendGroupName;
            friend.friendGroupDetail = eachGroup.noteFriendGroupDetail;
            friend.friendName = name;
            for (noteFriend *eachFriend in self.noteFriends) {
                if ([name isEqualToString:eachFriend.noteUserName]) {
                    friend.friendManifesto = eachFriend.noteUserManifesto;
                    break;
                }
            }
        }
    }
    NSError *error = nil;
    if (self.friendMOC.hasChanges) {
        [self.friendMOC save:&error];
    }
    if (error) {
        NSLog(@"core data insert init data error : %@",error);
    }
    
    NSLog(@"noteMainTwoViewController.m\nview init data");
    
    
}

- (void) addSearchBar{
    UISearchController *mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    mySearchController.searchBar.placeholder = @" Input what you want to search";
    mySearchController.searchResultsUpdater = self;
    mySearchController.delegate = self;
    mySearchController.dimsBackgroundDuringPresentation = NO;
    mySearchController.hidesNavigationBarDuringPresentation = YES;
    //mySearchController.searchBar.frame = CGRectMake(0, 20, self.view.bounds.size.width, noteFriendSearchBarHeight);
    [mySearchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    self.noteFriendTableView.tableHeaderView = mySearchController.searchBar;
    self.noteFriendSearchController = mySearchController;
}




#pragma mark - table view data source method
//返回分组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *eachFriendGroups = [self.friendFRC sections];
    return eachFriendGroups.count;
}

//返回每组行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *eachFriendGroups = [self.friendFRC sections];
    id<NSFetchedResultsSectionInfo> eachFriendGroup = eachFriendGroups[section];
    return [eachFriendGroup numberOfObjects];
}

//返回组索引
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    //获取section数组
    NSArray *eachFriendGroups = [self.friendFRC sections];
    
    NSMutableArray *groupIndexs = [NSMutableArray arrayWithCapacity:eachFriendGroups.count];
    for (id<NSFetchedResultsSectionInfo> eachFriendGroup in eachFriendGroups) {
        [groupIndexs addObject:[eachFriendGroup name]];
    }
    return groupIndexs;
    
}

//返回每一行的单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKeyFriend";
    UITableViewCell *eachFriendCell;
    
    eachFriendCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!eachFriendCell) {
        eachFriendCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Friend *eachFriend = [self.friendFRC objectAtIndexPath:indexPath];
    eachFriendCell.textLabel.text = eachFriend.friendName;
    eachFriendCell.detailTextLabel.text = eachFriend.friendManifesto;
    if (eachFriend.friendPhoto != nil) {
        UIImage *friendPhoto = [UIImage imageWithData:eachFriend.friendPhoto];
        eachFriendCell.imageView.image = friendPhoto;
    }else{
        drawPhoto *myImage = [[drawPhoto alloc] init];
        eachFriendCell.imageView.image = [myImage drawPersonPhotoWithWidth:48.0 height:48.0 positionX:5.0 positionY:5.0 color:[UIColor grayColor]];
    }
    
    return eachFriendCell;
}

//返回每组的头标题名称
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *eachFriendGroups = [self.friendFRC sections];
    id<NSFetchedResultsSectionInfo> eachFriendGroup = eachFriendGroups[section];
    return [eachFriendGroup name];
}

//返回每组的尾说明
- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSArray *eachFriendGroups = [self.friendFRC sections];
    id<NSFetchedResultsSectionInfo> eachFriendGroup = eachFriendGroups[section];
    NSString *detailString = [NSString stringWithFormat:@"my %@ friend group",[eachFriendGroup name]];
    return detailString;
}


#pragma mark - table view delegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //不加此句，二级目录返回时处于选取状态；加上此句，二级目录返回时处于非选取状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取storyboard的实例
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取目标viewController的实例，必须在storyboard的右侧标明【storyboard ID】
    editFriendInfoViewController *addFriendController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addFriendController"];
    
    Friend *selectFriend = [self.friendFRC objectAtIndexPath:indexPath];
    [addFriendController setValue:selectFriend forKey:@"noteFriend"];
    
    [self presentViewController:addFriendController animated:YES completion:nil];
    
}


#pragma mark - table view other methods
//开启编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearching) {
        return NO;
    }else{
        return YES;
    }
}

//点击删除时获取cell对应的索引在CoreData中的实体对象，然后通过上下文进行删除，再save一下就行了
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //通过CoreData删除对象
        //通过indexpath获取需要删除的实体
        Friend *deleteFriend = [self.friendFRC objectAtIndexPath:indexPath];
        
        //通过上下文删除实体
        [self.friendMOC deleteObject:deleteFriend];
        
        //通过上下文进行保存操作，并进行错误处理
        NSError *error = nil;
        if (![self.friendMOC save:&error]) {
            NSLog(@"noteMainTwoViewController.m\ndelete Table View Data error : %@",error);
        }
    }
}


#pragma mark - add friend view controller
//选取cell后触发，跳转到修改值的界面（与新增界面共用一个）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //判断sender是否为tableviewcell的对象
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        //做一个类型转换
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        
        //通过tableview获取cell对应的索引，然后通过索引获取对应的实例对象
        NSIndexPath *selectCellIndexPath = [self.noteFriendTableView indexPathForCell:selectCell];
        
        //用FetchedResultsController通过indexpath获取实例
        Friend *selectFriend = [self.friendFRC objectAtIndexPath:selectCellIndexPath];
        
        //获取目标视图
        UIViewController *destinationViewController = [segue destinationViewController];
        
        //通过KVC传递参数
        [destinationViewController setValue:selectFriend forKey:@"noteFriend"];
    }else{
        NSLog(@"sender is %@",sender);
    }
}


#pragma mark - fetched results controller delegate
//当CoreData的数据正在发生变化的时候，FRC产生的回调
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.noteFriendTableView beginUpdates];
}

//分区改变状况（section数据源发生改变）
- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.noteFriendTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.noteFriendTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
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
            [self.noteFriendTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.noteFriendTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.noteFriendTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.noteFriendTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.noteFriendTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

//当CoreData的数据完成改变时，FRC产生的回调
- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.noteFriendTableView endUpdates];
}


#pragma mark - search bar delegate
//取消搜索
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.isSearching = NO;
    self.noteFriendSearchController.searchBar.text = @"";
    [self.noteFriendTableView reloadData];
}

//输入搜索关键字
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.isSearching = YES;
    [self.noteFriendTableView reloadData];
}

//点击虚拟键盘上的搜索按钮
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (!self.isSearching) {
        self.isSearching = YES;
        [self.noteFriendTableView reloadData];
    }
    [self.noteFriendSearchController.searchBar resignFirstResponder];
}


#pragma mark - search results delegate
//搜索形成的新数据
- (void) updateSearchResultsForSearchController:(UISearchController *)searchController{
    //新建查询语句
    NSFetchRequest *searchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    
    //排序规则
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"friendGroupName" ascending:YES];
    searchRequest.sortDescriptors = @[sortDescriptor];
    
    //添加谓语
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"friendName contains %@",searchController.searchBar.text];
    searchRequest.predicate = searchPredicate;
    
    //把查询结果存入FetchedResultsController中
    self.friendFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:searchRequest
                                                         managedObjectContext:self.friendMOC
                                                           sectionNameKeyPath:@"friendGroupName"
                                                                    cacheName:nil];
    
    //执行FetchedResultsController，并处理错误
    NSError *error = nil;
    if (![self.friendFRC performFetch:&error]) {
        NSLog(@"noteMainTwoViewController.m\nFetched search Data error : %@",error);
    }
    
    [self.noteFriendTableView reloadData];
}




@end
