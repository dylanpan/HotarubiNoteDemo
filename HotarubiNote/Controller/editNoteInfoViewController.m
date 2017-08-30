//
//  editNoteInfoViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/16.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "editNoteInfoViewController.h"
#define noteFriendEditToolBarHeight 44.0

@interface editNoteInfoViewController ()

@property (strong, nonatomic) noteMainViewController *noteMainViewController;
@property (strong, nonatomic) maskLayerViewController *maskLayerViewController;

@end

@implementation editNoteInfoViewController

- (NSArray *) myLocationZone{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"Kalimdor", @"Northrend", nil];
    if (!_myLocationZone) {
        _myLocationZone = array;
    }
    return _myLocationZone;
}

- (NSDictionary *) myLocationCity{
    NSMutableArray *cityOne = [[NSMutableArray alloc] initWithObjects:@"Stromgarde", @"Azeroth", @"Dalaran", @"Gilneas", @"Alterac", @"KulTiras", @"Lordaeron", nil];
    NSMutableArray *cityTwo = [[NSMutableArray alloc] initWithObjects:@"CrystalsongForest", @"GrizzlyHills", @"HowlingFjord", @"IcecrownGlacier", @"SholazarBasin", nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:cityOne, @"Kalimdor", cityTwo, @"Northrend", nil];
    if (!_myLocationCity) {
        _myLocationCity = dict;
    }
    return _myLocationCity;
}

- (NSInteger) selectZone{
    if (!_selectZone) {
        _selectZone = 0;
    }
    return _selectZone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addToolBar];
    
    [self initData];
    
    //设置textfield的代理
    self.noteLimitedTimeTextField.delegate = self;
    self.noteLocationTextField.delegate = self;
    
    //初始化date picker
    self.noteLimitedTimePicker = [[UIDatePicker alloc] init];
    self.noteLimitedTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    //设置地区
    self.noteLimitedTimePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //替换键盘
    self.noteLimitedTimeTextField.inputView = self.noteLimitedTimePicker;
    //滑动触发
    [self.noteLimitedTimePicker addTarget:self action:@selector(rollDatePicker:) forControlEvents:UIControlEventValueChanged];
    
    //初始化location picker
    self.noteLocationPicker = [[UIPickerView alloc] init];
    self.noteLocationPicker.delegate = self;
    self.noteLocationPicker.dataSource = self;
    self.noteLocationTextField.inputView = self.noteLocationPicker;
    
    //添加UIImage的tap手势触发跳转到选取图片的页面
    UITapGestureRecognizer *tapContentPhotoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentPhoto)];
    [self.noteContentPhotoImageView addGestureRecognizer:tapContentPhotoGestureRecognizer];
    //打开UIImageView交互
    self.noteContentPhotoImageView.userInteractionEnabled = YES;
    
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    self.hnoteMOC = myCoreDataManager.managedObjectContext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData{
    if (self.hnote != nil) {
        self.originatorName = self.hnote.originatorName;//有问题，目前没有登陆，值为空
        self.noteTitleTextField.text = self.hnote.originatorTitle;
        self.noteSubtitleTextField.text = self.hnote.originatorSubtitle;
        self.noteContentTextView.text = self.hnote.originatorContent;
        self.noteLocationTextField.text = self.hnote.originatorLocation;
        NSDateFormatter *limitedTimeFormat = [[NSDateFormatter alloc] init];
        [limitedTimeFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.noteLimitedTimeTextField.text = [limitedTimeFormat stringFromDate:self.hnote.originatorLimitedTime];
        if (self.hnote.originatorContenPhoto != nil) {
            UIImage *contentPhoto = [UIImage imageWithData:self.hnote.originatorContenPhoto];
            self.noteContentPhotoImageView.image = contentPhoto;
        }
    }else{
        //赋予选取图片之前已经录入的值
        self.noteTitleTextField.text = [self.getData valueForKey:@"title"];
        self.noteSubtitleTextField.text = [self.getData valueForKey:@"subtitle"];
        self.noteContentTextView.text = [self.getData valueForKey:@"content"];
        self.noteLocationTextField.text = [self.getData valueForKey:@"location"];
        self.noteLimitedTimeTextField.text = [self.getData valueForKey:@"time"];
        self.noteContentPhotoImageView.image = self.myPickImage;
    }
}

- (void) addToolBar{
    self.noteInfoEditToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteFriendEditToolBarHeight)];
    [self.view addSubview:self.noteInfoEditToolBar];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEdit)];
    NSArray *buttonArray = [NSArray arrayWithObjects:cancelButton, flexibleButton, doneButton, nil];
    self.noteInfoEditToolBar.items = buttonArray;
    
    self.noteInfoEditToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    //创建约束对象(顶部)
    NSLayoutConstraint *toolBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.noteInfoEditToolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    //添加约束对象
    [self.view addConstraint:toolBarTopConstraint];
    
    //创建约束对象(左边)
    NSLayoutConstraint *toolBarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.noteInfoEditToolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarLeftConstraint];
    
    //创建约束对象(右边)
    NSLayoutConstraint *toolBarRightConstraint = [NSLayoutConstraint constraintWithItem:self.noteInfoEditToolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarRightConstraint];
    
    //创建约束对象(高度)
    NSLayoutConstraint *toolBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.noteInfoEditToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:noteFriendEditToolBarHeight];
    //添加约束对象
    [self.noteInfoEditToolBar addConstraint:toolBarHeightConstraint];
}

- (void) cancelEdit{
    if ([self.sourceViewController isKindOfClass:[maskLayerViewController class]]) {
        NSLog(@"source view controller while click cancel button:%@",self.sourceViewController);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        noteMainViewController *noteViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"noteTabBarController"];
        [self presentViewController:noteViewController animated:YES completion:nil];
    }else{
        NSLog(@"source view controller while click cancel button:%@",self.sourceViewController);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) doneEdit{
    //如果noteFriend为空则创建，如果已存在则更新
    if (self.hnote == nil) {
        self.hnote = [NSEntityDescription insertNewObjectForEntityForName:@"HNote" inManagedObjectContext:self.hnoteMOC];
    }
    
    //设置数据信息
    self.hnote.originatorName = [NSString stringWithFormat:@"Unknown"];//有问题，目前没有登陆，值为空
    self.hnote.originatorTitle = self.noteTitleTextField.text;
    self.hnote.originatorSubtitle = self.noteSubtitleTextField.text;
    self.hnote.originatorContent = self.noteContentTextView.text;
    self.hnote.originatorLocation = self.noteLocationTextField.text;
    NSDateFormatter *limitedTimeFormat = [[NSDateFormatter alloc] init];
    [limitedTimeFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.hnote.originatorLimitedTime = [limitedTimeFormat dateFromString:self.noteLimitedTimeTextField.text];
    if (self.noteContentPhotoImageView.image == nil) {
        drawPhoto *noteContentImage = [[drawPhoto alloc] init];
        self.hnote.originatorContenPhoto = UIImagePNGRepresentation([noteContentImage drawContentPhotoWithWidth:250.0 height:100.0 positionX:0.0 positionY:0.0 color:[UIColor yellowColor]]);
    }else{
        self.hnote.originatorContenPhoto = UIImagePNGRepresentation(self.noteContentPhotoImageView.image);
    }
    if (self.hnote.originatorPhoto == nil) {
        drawPhoto *noteContentImage = [[drawPhoto alloc] init];
        self.hnote.originatorPhoto = UIImagePNGRepresentation([noteContentImage drawPersonPhotoWithWidth:50.0 height:50.0 positionX:0.0 positionY:0.0 color:[UIColor yellowColor]]);
    }
    
    //通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if (self.hnoteMOC.hasChanges) {
        [self.hnoteMOC save:&error];
    }
    
    //错误处理
    if (error) {
        NSLog(@"editFriendInfoViewController.m\nedit friend info error : %@",error);
    }
    
    //保存成功后跳转到列表界面
    if ([self.sourceViewController isKindOfClass:[maskLayerViewController class]]) {
        NSLog(@"source view controller while click done button:%@",self.sourceViewController);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        noteMainViewController *noteViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"noteTabBarController"];
        [self presentViewController:noteViewController animated:YES completion:nil];
    }else{
        NSLog(@"source view controller while click done button:%@",self.sourceViewController);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void) tapContentPhoto{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    secondViewController *addContentPhotoController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addNoteContentPhotoViewController"];
    
    //数据传递
    NSMutableDictionary *saveData = [[NSMutableDictionary alloc] init];
    [saveData setValue:self.noteTitleTextField.text forKey:@"title"];
    [saveData setValue:self.noteSubtitleTextField.text forKey:@"subtitle"];
    [saveData setValue:self.noteLocationTextField.text forKey:@"location"];
    [saveData setValue:self.noteLimitedTimeTextField.text forKey:@"time"];
    [saveData setValue:self.noteContentTextView.text forKey:@"content"];
    [addContentPhotoController setValue:saveData forKey:@"saveData"];

    [self presentViewController:addContentPhotoController animated:YES completion:nil];
}


#pragma mark - text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //不让键盘输入
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑的时候对text field赋初值
    if (textField == self.noteLocationTextField) {
        [self pickerView:self.noteLocationPicker didSelectRow:0 inComponent:0];
    }else{
        [self rollDatePicker:self.noteLimitedTimePicker];
    }
}

- (void) rollDatePicker:(UIDatePicker *)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:sender.date];
    self.noteLimitedTimeTextField.text = dateString;
}


#pragma mark - picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.myLocationZone.count;
    }
    return [[self.myLocationCity objectForKey:[self.myLocationZone objectAtIndex:self.selectZone]] count];
}

#pragma mark - picker view delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectZoneName = [[NSString alloc] init];
    NSString *selectCityName = [[NSString alloc] init];
    if (component == 0) {
        self.selectZone = row;
        //重载第二列
        [self.noteLocationPicker reloadComponent:1];
        //设置第二列默认值
        [self.noteLocationPicker selectRow:0 inComponent:1 animated:YES];
        
        selectZoneName = self.myLocationZone[self.selectZone];
        selectCityName = [[self.myLocationCity objectForKey:selectZoneName] objectAtIndex:0];
    }else{
        selectZoneName = self.myLocationZone[self.selectZone];
        selectCityName = [[self.myLocationCity objectForKey:selectZoneName] objectAtIndex:row];
    }
    
    self.noteLocationTextField.text = [NSString stringWithFormat:@"%@ %@",selectZoneName,selectCityName];
}

//picker view显示具体文字，其他的可用view for row方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [self.myLocationZone objectAtIndex:row];
    }
    return [[self.myLocationCity objectForKey:[self.myLocationZone objectAtIndex:self.selectZone]] objectAtIndex:row];
}

#pragma mark - keyboard exit
//点击return后触发，隐藏键盘
- (IBAction)titleTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [self.noteSubtitleTextField becomeFirstResponder];
}
- (IBAction)subtitleTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [self.noteLocationTextField becomeFirstResponder];
}

- (IBAction)locationTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [self.noteLimitedTimeTextField becomeFirstResponder];
}

- (IBAction)limitedTimeTextField_DidEndOnExit:(id)sender{
    [sender resignFirstResponder];
}

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
