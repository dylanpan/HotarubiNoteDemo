//
//  maskLayerViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "maskLayerViewController.h"

@interface maskLayerViewController ()

@property (strong, nonatomic) maskAnimator *maskAnimator;

@end

@implementation maskLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void) initView{
    self.myImageView = [[UIImageView alloc] init];
    self.myImageView.frame = CGRectMake(self.myScrollView.bounds.origin.x, self.myScrollView.bounds.origin.y, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);//必须设置好imageView的位置和大小，否则缩放后不能移动图片
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.myImageView.image = self.myImage;
    NSLog(@"%@",self.myImage);
    
    self.myScrollView.contentSize = self.myImage.size;
    self.myScrollView.delegate = self;
    self.myScrollView.maximumZoomScale = 2.0;
    self.myScrollView.minimumZoomScale = 0.5;
    
    [self.myScrollView addSubview:self.myImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchUpInsideCancelButton:(id)sender {
    if (self.maskLayerDelegate && [self.maskLayerDelegate respondsToSelector:@selector(dismissPresentedViewControllerTwo:)]){
        [self.maskLayerDelegate dismissPresentedViewControllerTwo:self];
        NSLog(@"maskLayerViewController.m\ncall dismiss delegate\n");
    }else{
        NSLog(@"maskLayerViewController.m\ndidnot call dismiss delegate\n");
    }
}


- (IBAction)touchUpInsideDoneButton:(id)sender{
    __weak maskLayerViewController *weakSelf = self;
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
        if ([[vc class] isEqual:[editNoteInfoViewController class]]) {
            break;
        }
    }
    [vc dismissViewControllerAnimated:YES completion:^{
        //数据传递
        [vc setValue:weakSelf forKey:@"sourceViewController"];
        NSMutableDictionary *mySentData = [[NSMutableDictionary alloc] initWithDictionary:weakSelf.sentData];
        [mySentData setObject:weakSelf.myImage forKey:@"image"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mySentDataNotification" object:self userInfo:mySentData];
        NSLog(@"maskLayerViewController.m\npass dictionary\n");
    }];
    
}

#pragma mark - scroll view delegate
//实现放大或缩小
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.myImageView;
}
//缩放过程中调用
- (void) scrollViewDidZoom:(UIScrollView *)scrollView{
    
}

//缩放完成后调用
- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}

@end

