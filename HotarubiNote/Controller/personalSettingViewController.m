//
//  personalSettingViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/22.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "personalSettingViewController.h"

#define personalSettingToolBarHeight 44.0

@interface personalSettingViewController ()

@end

@implementation personalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    self.hnoteMOC = myCoreDataManager.managedObjectContext;
    
    [self initData];
    [self addToolBar];
    
    self.authorPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    [self.authorPhoto addGestureRecognizer:tapImageView];
    
    //初始化并配置imagepicker
    self.authorPhotoPicker = [[UIImagePickerController alloc] init];
    //注册回调
    self.authorPhotoPicker.delegate = self;
}

- (void) initData{
    self.authorPhoto.image = [[UIImage alloc] initWithData:self.hnote.originatorPhoto];
    self.authorNameTextField.text = self.hnote.originatorName;
}

//点击头像，弹出下面的sheet选项，摄像头或者本地照片
- (void) addPhoto{
    NSLog(@"did tap photo");
    __weak personalSettingViewController *weakSelf = self;
    //创建ActionSheet
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Change Photo" message:@"pick one way what you perfer" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *localAction = [UIAlertAction actionWithTitle:@"LOCAL PHOTO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click localAction");
        if ([weakSelf isPhotoLibraryAvailable]) {
            [weakSelf.authorPhotoPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            if ([weakSelf canUserPickPhotosFromPhotoLibrary]) {
                [mediaTypes addObject:(NSString *)kUTTypeImage];
            }
            if ([weakSelf canUserPickVideosFromPhotoLibrary]) {
                [mediaTypes addObject:(NSString *)kUTTypeMovie];
            }
            [weakSelf.authorPhotoPicker setMediaTypes:mediaTypes];
            [weakSelf presentViewController:weakSelf.authorPhotoPicker animated:YES completion:nil];
        }else{
            NSLog(@"Photo library is not available");
        }
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click cameraAction");
        if ([weakSelf isCameraAvailable] && [weakSelf doesCameraSupportTakingPhotos]) {
            [weakSelf.authorPhotoPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            NSString *requireMediaType = (NSString *)kUTTypeImage;
            NSArray *mediaTypes = [NSArray arrayWithObjects:requireMediaType, nil];
            [weakSelf.authorPhotoPicker setMediaTypes:mediaTypes];
            [weakSelf.authorPhotoPicker setAllowsEditing:YES];
            [weakSelf presentViewController:weakSelf.authorPhotoPicker animated:YES completion:nil];
        }else{
            NSLog(@"Camera is not available");
        }
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click cancelAction");
    }];
    [actionSheet addAction:localAction];
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Image Picker Controller Delegate
//未选取图片，在ImagePickerView取消操作
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //跳转到原来界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//已选取图片，在ImagePickerView取消操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取到编辑好的图片
    UIImage *image = nil;
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断获取类型：图片
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        if ([picker allowsEditing]) {
            //获取编辑后的图片
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            //获取原图片
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //保存到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
    }
    //把获取的图片设置成头像
    self.authorPhoto.image = image;
    //返回到原来的界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image Picker Controller other method
//保存拍的照片到相册后调用此方法
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil) {
        NSLog(@"Image was saved successfully");
    }else{
        NSLog(@"An error happened while saving the image");
        NSLog(@"error = %@",paramError);
    }
}



#pragma mark - tool bar
- (void) addToolBar{
    self.personalSettingToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, personalSettingToolBarHeight)];
    [self.view addSubview:self.personalSettingToolBar];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEdit)];
    NSArray *buttonArray = [NSArray arrayWithObjects:cancelButton, flexibleButton, doneButton, nil];
    self.personalSettingToolBar.items = buttonArray;
}

//点击取消，不保存修改操作
- (void) cancelEdit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击完成，保存新名称和新头像
- (void) doneEdit{
    if (self.authorPhoto.image != nil) {
        self.hnote.originatorPhoto = UIImagePNGRepresentation(self.authorPhoto.image);
    }else{
        drawPhoto *noteContentImage = [[drawPhoto alloc] init];
        self.hnote.originatorPhoto = UIImagePNGRepresentation([noteContentImage drawPersonPhotoWithWidth:200.0 height:200.0 positionX:0.0 positionY:0.0 color:[UIColor blueColor]]);
    }
    self.hnote.originatorName = self.authorNameTextField.text;
    
    //通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if (self.hnoteMOC.hasChanges) {
        [self.hnoteMOC save:&error];
    }
    
    //错误处理
    if (error) {
        NSLog(@"editFriendInfoViewController.m\nedit friend info error : %@",error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - keyboard exit
- (IBAction) authorNameTextField_DidEndOnExit:(id)sender{
    [sender resignFirstResponder];
}

//点击view的空白处后触发，隐藏键盘
- (IBAction) UIView_TouchDown:(id)sender{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

#pragma mark - camera method
//判断是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//判断前摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

//判断后摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//判断是否支持某种多媒体类型：拍照、视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaTpye sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaTpye length] == 0) {
        NSLog(@"Media type is empty");
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaTpye]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

//摄像头是否支持录像
- (BOOL) doesCameraSupportShootingVideos{
    return [self cameraSupportsMedia:(NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

//摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

//相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选取视频
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self cameraSupportsMedia:(NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选取照片
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
















@end
