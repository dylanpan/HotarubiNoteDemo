//
//  editFriendInfoViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "editFriendInfoViewController.h"

#define noteFriendEditToolBarHeight 44

@interface editFriendInfoViewController ()

@end

@implementation editFriendInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self addToolBar];
    
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    self.friendMOC = myCoreDataManager.managedObjectContext;
    
    //初始化并配置imagepicker
    self.noteFriendPhotoPicker = [[UIImagePickerController alloc] init];
    //picker是否可以编辑
    self.noteFriendPhotoPicker.allowsEditing = YES;
    //注册回调
    self.noteFriendPhotoPicker.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData{
    //初始化视图的相应控件
    self.noteFriendPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    self.noteFriendNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 100, 250, 40)];
    self.noteFriendManifestoTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 160, 250, 40)];
    
    self.noteFriendNameTextField.placeholder = @" Input your friend's name";
    self.noteFriendManifestoTextField.placeholder = @" Input your friend's manifesto";
    
    self.noteFriendNameTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.noteFriendNameTextField.layer.borderWidth = 1.0;
    self.noteFriendNameTextField.tag = 1;
    self.noteFriendManifestoTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.noteFriendManifestoTextField.layer.borderWidth = 1.0;
    self.noteFriendManifestoTextField.tag = 2;
    self.noteFriendPhotoButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.noteFriendPhotoButton.layer.borderWidth = 1.0;
    
    self.noteFriendNameTextField.text = self.noteFriend.friendName;
    self.noteFriendManifestoTextField.text = self.noteFriend.friendManifesto;
    
    [self.view addSubview:self.noteFriendPhotoButton];
    [self.view addSubview:self.noteFriendNameTextField];
    [self.view addSubview:self.noteFriendManifestoTextField];
    
    if (self.noteFriend.friendPhoto != nil) {
        UIImage *friendPhoto = [UIImage imageWithData:self.noteFriend.friendPhoto];
        [self.noteFriendPhotoButton setImage:friendPhoto forState:UIControlStateNormal];
    }
    
    [self.noteFriendPhotoButton addTarget:self action:@selector(tapNoteFriendPhotoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.noteFriendNameTextField.delegate = self;
    self.noteFriendManifestoTextField.delegate = self;
}

- (void) addToolBar{
    self.noteFriendEditToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteFriendEditToolBarHeight)];
    [self.view addSubview:self.noteFriendEditToolBar];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEdit)];
    NSArray *buttonArray = [NSArray arrayWithObjects:cancelButton, flexibleButton, doneButton, nil];
    self.noteFriendEditToolBar.items = buttonArray;
    
    self.noteFriendEditToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    //创建约束对象(顶部)
    NSLayoutConstraint *toolBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.noteFriendEditToolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    //添加约束对象
    [self.view addConstraint:toolBarTopConstraint];
    
    //创建约束对象(左边)
    NSLayoutConstraint *toolBarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.noteFriendEditToolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarLeftConstraint];
    
    //创建约束对象(右边)
    NSLayoutConstraint *toolBarRightConstraint = [NSLayoutConstraint constraintWithItem:self.noteFriendEditToolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    //添加约束对象
    [self.view addConstraint:toolBarRightConstraint];
    
    //创建约束对象(高度)
    NSLayoutConstraint *toolBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.noteFriendEditToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:noteFriendEditToolBarHeight];
    //添加约束对象
    [self.noteFriendEditToolBar addConstraint:toolBarHeightConstraint];
}

- (void) cancelEdit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) doneEdit{
    //如果noteFriend为空则创建，如果已存在则更新
    if (self.noteFriend == nil) {
        self.noteFriend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.friendMOC];
    }
    
    //设置数据信息
    self.noteFriend.friendName = self.noteFriendNameTextField.text;
    self.noteFriend.friendManifesto = self.noteFriendManifestoTextField.text;
    self.noteFriend.friendGroupName = [NSString stringWithFormat:@"%c",[self.noteFriendNameTextField.text characterAtIndex:0]];
    self.noteFriend.friendGroupDetail = @"no detail";
    self.noteFriend.friendPhoto = UIImagePNGRepresentation([self.noteFriendPhotoButton imageView].image);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    noteMainTwoViewController *friendListViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"friendListViewController"];
    
    NSUInteger index = (NSUInteger)([self.sectionsEditArray count]);
    NSMutableArray *sentArray = [[NSMutableArray alloc] init];
    sentArray = self.sectionsEditArray;
    [sentArray insertObject:[NSNumber numberWithBool:YES] atIndex:index];
    [friendListViewController setValue:sentArray forKey:@"sectionsArray"];
    
    //通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if (self.friendMOC.hasChanges) {
        [self.friendMOC save:&error];
    }
    
    //错误处理
    if (error) {
        NSLog(@"editFriendInfoViewController.m\nedit friend info error : %@",error);
    }
    
    //保存成功后跳转到列表界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击图片按钮设置图片
- (IBAction)tapNoteFriendPhotoButton:(id)sender{
    //跳到ImagePickerView来获取按钮
    [self presentViewController:self.noteFriendPhotoPicker animated:YES completion:nil];
}

//未选取图片，在ImagePickerView取消操作
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //跳转到原来界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//已选取图片，在ImagePickerView取消操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取到编辑好的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //把获取的图片设置成头像
    [self.noteFriendPhotoButton setImage:image forState:UIControlStateNormal];
    
    //返回到原来的界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - textfield delegate
//点击return后触发，隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        return [self.noteFriendManifestoTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        return YES;
    }
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
