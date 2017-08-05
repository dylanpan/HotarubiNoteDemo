//
//  noteMainTwoViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainTwoViewController.h"

#define noteFriendSearchBarHeight 44

@interface noteMainTwoViewController ()

@end

@implementation noteMainTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    
    //创建一个分组样式的table view
    self.noteFriendTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.noteFriendTableView.dataSource = self;
    
    [self.view addSubview:self.noteFriendTableView];
    
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

- (void) addSearchBar{
    CGRect searchBarRect = CGRectMake(0, 0, self.view.frame.size.width, noteFriendSearchBarHeight);
    self.noteFriendSearchBar = [[UISearchBar alloc] initWithFrame:searchBarRect];
    self.noteFriendSearchBar.placeholder = @"Please hit me ....";
    self.noteFriendSearchBar.delegate = self;
    self.noteFriendTableView.tableHeaderView = self.noteFriendSearchBar;
}

#pragma mark - data source method
//返回分组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isSearching) {
        return 1;
    }else{
       return self.noteFriendGroups.count;
    }
}

//返回每组行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearching) {
        return self.noteSearchFriends.count;
    }else{
        noteFriendGroup *eachNoteFriendGroup = self.noteFriendGroups[section];
        return eachNoteFriendGroup.noteFriends.count;
    }
}

//返回组索引
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.isSearching) {
        return nil;
    }else{
        NSMutableArray *groupIndexs = [[NSMutableArray alloc] init];
        for (noteFriendGroup *groups in self.noteFriendGroups) {
            [groupIndexs addObject:groups.noteFriendGroupName];
        }
        return groupIndexs;
    }
}

//返回每一行的单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    UITableViewCell *eachNoteCell;
    eachNoteCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!eachNoteCell) {
        eachNoteCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (self.isSearching) {
        noteFriend *noteEachSearchFriend = self.noteSearchFriends[indexPath.row];
        eachNoteCell.textLabel.text = noteEachSearchFriend.noteUserName;
        eachNoteCell.detailTextLabel.text = noteEachSearchFriend.noteUserManifesto;
    }else{
        //每一个noteFriendGroups数组里面的noteFriends的数组
        noteFriendGroup *eachNoteGroup = self.noteFriendGroups[indexPath.section];
        NSString *eachNoteFriendNameInGroup = eachNoteGroup.noteFriends[indexPath.row];
        
        for (int i = 0; i < [self.noteFriends count]; i++) {
            //每一个noteFriends的数组
            noteFriend *eachNoteFriend = self.noteFriends[i];
            if([eachNoteFriend.noteUserName isEqualToString:eachNoteFriendNameInGroup]){
                eachNoteCell.textLabel.text = eachNoteFriend.noteUserName;
                eachNoteCell.detailTextLabel.text = eachNoteFriend.noteUserManifesto;
            }
        }
    }
    drawPhoto *myImage = [[drawPhoto alloc] init];
    eachNoteCell.imageView.image = [myImage drawPhotoWithWidth:48 andHeight:48 andPositionX:5 andPositionY:5 andColor:[UIColor orangeColor]];
    
    return eachNoteCell;
}

//返回每组的头标题名称
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.isSearching) {
        return nil;
    }else{
        noteFriendGroup *eachNoteGroup = self.noteFriendGroups[section];
        return eachNoteGroup.noteFriendGroupName;
    }
}

//返回每组的尾说明
- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (self.isSearching) {
        return nil;
    }else{
        noteFriendGroup *eachNoteGroup = self.noteFriendGroups[section];
        return eachNoteGroup.noteFriendGroupDetail;
    }
}


#pragma mark - table view delegate method


#pragma mark - search bar delegate
//取消搜索
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.isSearching = NO;
    self.noteFriendSearchBar.text = @"";
    [self.noteFriendTableView reloadData];
}

//输入搜索关键字
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([self.noteFriendSearchBar.text isEqualToString:@""]) {
        self.isSearching = NO;
        [self.noteFriendTableView reloadData];
    }else{
        [self searchDataWithKeyWord:self.noteFriendSearchBar.text];
    }
}

//点击虚拟键盘上的搜索按钮
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchDataWithKeyWord:self.noteFriendSearchBar.text];
    [self.noteFriendSearchBar resignFirstResponder];
}


//搜索形成的新数据
- (void) searchDataWithKeyWord:(NSString *)keyWord{
    self.isSearching = YES;
    self.noteSearchFriends = [[NSMutableArray alloc] init];
    [self.noteFriends enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        noteFriend *eachSearchFriend = obj;
        if ([eachSearchFriend.noteUserName.uppercaseString containsString:keyWord.uppercaseString] || [eachSearchFriend.noteUserManifesto.uppercaseString containsString:keyWord.uppercaseString]) {
            [self.noteSearchFriends addObject:eachSearchFriend];
        }
    }];
    [self.noteFriendTableView reloadData];
}






@end
