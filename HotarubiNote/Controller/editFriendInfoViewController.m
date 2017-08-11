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

@property (strong, nonatomic) noteMainTwoViewController *noteMainTwoViewController;

@end

@implementation editFriendInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化视图的相应控件
    self.noteFriendPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    self.noteFriendNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 100, 200, 40)];
    self.noteFriendManifestoTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 160, 200, 40)];
    
    self.noteFriendNameTextField.placeholder = @"input your friend's name";
    self.noteFriendManifestoTextField.placeholder = @"input your friend's manifesto";
    
    self.noteFriendNameTextField.text = self.noteFriend.friendName;
    self.noteFriendManifestoTextField.text = self.noteFriend.friendManifesto;
    
    if (self.noteFriend.friendPhoto != nil) {
        UIImage *friendPhoto = [UIImage imageWithData:self.noteFriend.friendPhoto];
        [self.noteFriendPhotoButton setImage:friendPhoto forState:UIControlStateNormal];
    }
    
    
    
    [self addToolBar];
    
    self.friendMOC = self.noteMainTwoViewController.friendMOC;
    
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


- (void) addToolBar{
    self.noteFriendEditToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, noteFriendEditToolBarHeight)];
    [self.view addSubview:self.noteFriendEditToolBar];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEdit)];
    NSArray *buttonArray = [NSArray arrayWithObjects:cancelButton, flexibleButton, doneButton, nil];
    self.noteFriendEditToolBar.items = buttonArray;
}

- (void) cancelEdit{
    
}

- (void) doneEdit{
    //如果noteFriend为空则创建，如果已存在则更新
    if (self.noteFriend == nil) {
        self.noteFriend = [NSEntityDescription insertNewObjectForEntityForName:@"AddressList" inManagedObjectContext:self.friendMOC];
    }
    
    //设置数据信息
    self.noteFriend.friendName = self.noteFriendNameTextField.text;
    self.noteFriend.friendManifesto = self.noteFriendManifestoTextField.text;
    self.noteFriend.friendGroupName = [NSString stringWithFormat:@"%c",[self.noteFriendManifestoTextField.text characterAtIndex:0]];
    self.noteFriend.friendGroupDetail = @"no detail";
    self.noteFriend.friendPhoto = UIImagePNGRepresentation([self.noteFriendPhotoButton imageView].image);
    
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
    
    //改成自定义的CollectionView获取图片
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/












@end
