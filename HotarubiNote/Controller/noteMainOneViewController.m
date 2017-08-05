//
//  noteMainOneViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainOneViewController.h"

#define noteMainToolBarHeight 44

@interface noteMainOneViewController ()

@end

@implementation noteMainOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    CGRect noteMainTableViewRect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.noteMainTableView = [[UITableView alloc] initWithFrame:noteMainTableViewRect style:UITableViewStyleGrouped];
    
    self.noteMainTableView.dataSource = self;
    self.noteMainTableView.delegate = self;
    
    [self.view addSubview:self.noteMainTableView];
    
    [self addToolBar];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initData{
    NSString *initOneNotePath = [[NSBundle mainBundle] pathForResource:@"noteMain" ofType:@"plist"];
    NSArray *initOneNoteArray = [NSArray arrayWithContentsOfFile:initOneNotePath];
    self.notes = [[NSMutableArray alloc] init];
    self.noteCells = [[NSMutableArray alloc] init];
    [initOneNoteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.notes addObject:[note noteWithDictionary:obj]];
        noteTableViewCell *noteCell = [[noteTableViewCell alloc] init];
        [self.noteCells addObject:noteCell];
    }];
}

- (void) addToolBar{
    self.noteMainToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteMainToolBarHeight)];
    [self.view addSubview:self.noteMainToolBar];
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeNote)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote)];
    NSArray *buttonArray = [NSArray arrayWithObjects:removeButton, flexibleButton, addButton, nil];
    self.noteMainToolBar.items = buttonArray;
}

- (void) removeNote{
    self.isInsert = NO;
    [self.noteMainTableView setEditing:!self.noteMainTableView.isEditing animated:YES];
}

- (void) addNote{
    self.isInsert = YES;
    [self.noteMainTableView setEditing:!self.noteMainTableView.isEditing animated:YES];
}

- (void) refreshData{
    UIRefreshControl *refreshDataControl = [[UIRefreshControl alloc] init];
    [refreshDataControl addTarget:self action:@selector(refreshNote:) forControlEvents:UIControlEventValueChanged];
    [self.noteMainTableView addSubview:refreshDataControl];
    [refreshDataControl beginRefreshing];
    [self refreshNote:refreshDataControl];
}

- (void) refreshNote:(UIRefreshControl *)refreshControl{
    [self initData];
    [refreshControl endRefreshing];
    [self.noteMainTableView reloadData];
}

#pragma mark - data source method
//返回分组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//返回每组行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notes.count;
}

//返回每一行的单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    noteTableViewCell *eachNoteCell;
    eachNoteCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!eachNoteCell) {
        eachNoteCell = [[noteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    note *eachNote = self.notes[indexPath.row];
    eachNoteCell.oneNote = eachNote;
    
    return eachNoteCell;
}

#pragma mark - table view delegate method
//重新设置cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    noteTableViewCell *eachCell = self.noteCells[indexPath.row];
    eachCell.oneNote = self.notes[indexPath.row];
    return eachCell.oneNoteHeight;
}

//左滑删除或者添加
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    note *willRemoveNote = self.notes[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notes removeObject:willRemoveNote];
        [self.noteMainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        if (self.notes.count == 0) {
            [self.noteMainTableView reloadData];
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSDictionary *noteNewOneDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"11", @"noteID",
                                              @"creat a new note", @"noteTitle",
                                              @"⭐️⭐️⭐️⭐️⭐️", @"noteStar",
                                              @"now", @"noteTime",
                                              @"tap the add button", @"noteContent",
                                              @"Abel", @"noteAuthor",
                                              @"1.png", @"noteAuthorPhoto",
                                              @"1.png", @"noteMainPhoto", nil];
        
        note *noteNewOne = [[note alloc] initWithDictionary:noteNewOneDictionary];
        [self.notes insertObject:noteNewOne atIndex:indexPath.row];
        [self.noteMainTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

//左侧出现不同状态的按钮
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isInsert) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

//右侧出现排序按钮
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    note *sourceNote = self.notes[sourceIndexPath.row];
    note *destinationNote = self.notes[destinationIndexPath.row];
    [self.notes removeObject:sourceNote];
    if (self.notes.count == 0) {
        [self.noteMainTableView reloadData];
    }
    [self.notes insertObject:destinationNote atIndex:destinationIndexPath.row];
}











@end
