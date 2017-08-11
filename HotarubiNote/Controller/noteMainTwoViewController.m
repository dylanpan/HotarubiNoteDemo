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

#pragma mark - create CoreData Context
//创建上下文
- (NSManagedObjectContext *) contextWithModelName:(NSString *)modelName{
    //创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //创建托管对象模型，并使用HotarubiNote.momd路径当作初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSLog(@"%@",modelPath);
    
    //创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //创建并关联SQLite数据库文件，如果已存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    NSLog(@"%@",dataPath);
    
    //上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}

- (NSManagedObjectContext *)friendMOC{
    if (!_friendMOC) {
        _friendMOC = [self contextWithModelName:@"HotarubiNote"];
    }
    return _friendMOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个分组样式的table view
    self.noteFriendTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.noteFriendTableView.dataSource = self;
    
    [self.view addSubview:self.noteFriendTableView];
    
    //[self initData];
    
    [self addToolBar];
    NSLog(@"11111111");
    self.friendMOC = [self contextWithModelName:@"HotarubiNote"];
    
    //通过CoreData获取SQLite的数据
    //通过实体名获取请求
    //NSFetchRequest *noteFriendTableViewDataRequest = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    NSFetchRequest *noteFriendTableViewDataRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *myEntityFriend = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:self.friendMOC];
    noteFriendTableViewDataRequest.entity = myEntityFriend;
    
    //定义分组和排序规则
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"friendGroupName" ascending:YES];
    
    //把排序和分组规则添加到请求中
    noteFriendTableViewDataRequest.sortDescriptors = @[sortDescriptor];
    
    NSLog(@"%@",noteFriendTableViewDataRequest);
    NSLog(@"%@",self.friendMOC);
    
    //把请求的结果转换成TableView显示的数据
    self.friendFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:noteFriendTableViewDataRequest
                                                              managedObjectContext:self.friendMOC
                                                                sectionNameKeyPath:@"friendGroupName"
                                                                         cacheName:nil];
    NSLog(@"%@",self.friendFRC);
    //执行FetchedResultsController，并处理错误
    NSError *error = nil;
    if ([self.friendFRC performFetch:&error]) {
        NSLog(@"noteMainTwoViewController.m\nFetched Table View Data error : %@",error);
    }
    NSLog(@"3333333");
    
    //注册回调，使TableView中的内容跟着CoreData变化，通过FRC的协议
    self.friendFRC.delegate = self;
    
    //先添加table view 再添加search bar，否则被覆盖
    [self addSearchBar];
    
    NSLog(@"noteMainTwoViewController.m\nview did load");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData{
    NSString *initNoteFriendsDataPath = [[NSBundle mainBundle] pathForResource:@"noteFriends" ofType:@"plist"];
    NSArray *initNoteFriendsDataArray = [NSArray arrayWithContentsOfFile:initNoteFriendsDataPath];
    self.noteFriends = [[NSMutableArray alloc] init];
    [initNoteFriendsDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.noteFriends addObject:[noteFriend noteFriendWithDictionary:obj]];
    }];
    
    NSString *initNoteFriendGroupsDataPath = [[NSBundle mainBundle] pathForResource:@"noteFriendGroups" ofType:@"plist"];
    NSArray *initNoteFriendGroupsDataArray = [NSArray arrayWithContentsOfFile:initNoteFriendGroupsDataPath];
    self.noteFriendGroups = [[NSMutableArray alloc] init];
    [initNoteFriendGroupsDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.noteFriendGroups addObject:[noteFriendGroup noteFriendGroupWithDictionary:obj]];
    }];
    
    NSLog(@"noteMainTwoViewController.m\nview init data");
}

- (void) addToolBar{
    self.noteFriendToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteFriendToolBarHeight)];
    [self.view addSubview:self.noteFriendToolBar];
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeFriend)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:@selector(searchFriend)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    NSArray *buttonArray = [NSArray arrayWithObjects:removeButton, flexibleButton, searchButton, addButton, nil];
    self.noteFriendToolBar.items = buttonArray;
}

- (void) removeFriend{
    [self.noteFriendTableView setEditing:!self.noteFriendTableView.isEditing animated:YES];
    
}

- (void) addFriend{
    [self.noteFriendTableView setEditing:!self.noteFriendTableView.isEditing animated:YES];
    
}

- (void) searchFriend{
    
}

- (void) addSearchBar{
    self.noteFriendSearchContrller = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.noteFriendSearchContrller.searchBar.placeholder = @"input what you want....";
    self.noteFriendSearchContrller.searchResultsUpdater = self;
    self.noteFriendSearchContrller.delegate = self;
    self.noteFriendSearchContrller.dimsBackgroundDuringPresentation = YES;
    [self.noteFriendSearchContrller.searchBar sizeToFit];
    [self.view addSubview:self.noteFriendSearchContrller.searchBar];
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
    
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
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
        eachFriendCell.imageView.image = [myImage drawPhotoWithWidth:48 andHeight:48 andPositionX:5 andPositionY:5 andColor:[UIColor orangeColor]];
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
    NSString *detailString = [NSString stringWithFormat:@"%@ do not have detail string....",[eachFriendGroup name]];
    return detailString;
}


#pragma mark - table view delegate method


#pragma mark - table view other methods
//开启编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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

//选取cell后触发，跳转到修改值的界面
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
    }
}


#pragma mark - fetched results controller delegate
//当CoreData的数据正在发生变化的时候，FRC产生的回调
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.noteFriendTableView beginUpdates];
}

//分区改变状况
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

//数据改变状况
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
    self.noteFriendSearchContrller.searchBar.text = @"";
    [self.noteFriendTableView reloadData];
}

//输入搜索关键字
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.isSearching = YES;
    
    [self.noteFriendTableView reloadData];
}
/*
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //新建查询语句
    NSFetchRequest *searchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    
    //排序规则
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"friendGroupName" ascending:YES];
    searchRequest.sortDescriptors = @[sortDescriptor];
    
    //添加谓语
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"friendName contains %@ OR friendManifesto",searchText];
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
    
}*/

//点击虚拟键盘上的搜索按钮
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (!self.isSearching) {
        self.isSearching = YES;
        [self.noteFriendTableView reloadData];
    }
    [self.noteFriendSearchContrller.searchBar resignFirstResponder];
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
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"friendName contains %@ OR friendManifesto",searchController.searchBar.text];
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
