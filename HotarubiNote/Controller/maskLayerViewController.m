//
//  maskLayerViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/24.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "maskLayerViewController.h"

@interface maskLayerViewController ()

@property (strong,nonatomic) maskAnimator *maskAnimator;

@end

@implementation maskLayerViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.maskAnimator = [[maskAnimator alloc] init];
        NSLog(@"maskLayerViewController.m\ninit animator successed\n");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)touchUpInsideDoneButton:(id)sender{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    editNoteInfoViewController *destinationViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addNoteController"];
    [destinationViewController setValue:self.myImage forKey:@"myPickImage"];
    [destinationViewController setValue:self forKey:@"sourceViewController"];
    
    //数据传递
    [destinationViewController setValue:self.sentData forKey:@"getData"];
    [self presentViewController:destinationViewController animated:YES completion:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPickImage"]) {
        UIViewController *destinationController = [segue destinationViewController];
        
        destinationController.transitioningDelegate = self;
        destinationController.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    
}

#pragma mark - modal transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    NSLog(@"maskLayerViewController.m\nmodal present transition delegate\n");
    return self.maskAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSLog(@"maskLayerViewController.m\nmodal dismiss transition delegate\n");
    return self.maskAnimator;
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

