//
//  noteMainFourViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/17.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainFourViewController.h"

@interface noteMainFourViewController ()

@end

@implementation noteMainFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    //创建一个分组样式的table view
    self.noteMeSettingTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.noteMeSettingTableView.dataSource = self;
    self.noteMeSettingTableView.delegate = self;
    
    [self.view addSubview:self.noteMeSettingTableView];
    
    NSLog(@"noteMainFourViewController.m\nview did load");
    
}

- (void) initData{
    
    self.noteMeSettings = [NSMutableArray arrayWithObjects:@"Dylan", @"NoteStatistics", @"NoteChickenSoup", @"NoteShare", @"NoteAchievement", @"NoteRewardPoint", @"NoteSetting", @"NoteAboutUs", @"NoteFeedback", nil];
    
    NSLog(@"noteMainFourViewController.m\nview init data");
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


#pragma mark - data source
//返回分组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//返回每组行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noteMeSettings.count;
}

//返回每一行的单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    UITableViewCell *eachNoteCell;
    eachNoteCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!eachNoteCell) {
        eachNoteCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    eachNoteCell.textLabel.text = self.noteMeSettings[indexPath.row];
    
    drawPhoto *myImage = [[drawPhoto alloc] init];
    eachNoteCell.imageView.image = [myImage drawPhotoWithWidth:48 andHeight:48 andPositionX:5 andPositionY:5 andColor:[UIColor orangeColor]];
    
    //右箭头
    eachNoteCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return eachNoteCell;
}


#pragma mark - table view delegate method
//设置cell行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
