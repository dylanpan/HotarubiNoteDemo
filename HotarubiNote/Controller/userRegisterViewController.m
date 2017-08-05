//
//  userRegisterViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "userRegisterViewController.h"

@interface userRegisterViewController ()

@property (strong, nonatomic) customAnimator *customAnimator;

@end

@implementation userRegisterViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.customAnimator = [[customAnimator alloc] init];
        NSLog(@"userRegisterViewController.m\ninit animator in navigator successed\n");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.delegate = self;//设置不成功
    self.delegate = self;//设置成功
    
    //设置状态，防止触发手势的时候卡屏
    self.isInteractive = NO;
    
    //添加手势
    UIPanGestureRecognizer *myPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panNavigationControllerGesture:)];
    [self.view addGestureRecognizer:myPanGestureRecognizer];
    NSLog(@"userRegisterViewController.m\n1.0\n");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - navagation contrroller dalegate
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        self.customAnimator.operation = operation;
        NSLog(@"userRegisterViewController.m\ncall navagation controller dalegate push\n");
        return self.customAnimator;
    }else if (operation == UINavigationControllerOperationPop) {
        self.customAnimator.operation = operation;
        NSLog(@"userRegisterViewController.m\ncall navagation controller dalegate pop\n");
        return self.customAnimator;
    }else{
        NSLog(@"userRegisterViewController.m\ndidnot call navagation controller dalegate");
        return nil;
    }
}

//驱动Interactive
- (id<UIViewControllerInteractiveTransitioning>) navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.isInteractive) {
        NSLog(@"userRegisterViewController.m\n1.00\n");
        return self.myPanInteractiveTransition;
    }else{
        NSLog(@"userRegisterViewController.m\n1.01\n");
        return nil;
    }
}

//Interactive配合
#pragma mark - Interactive
- (void) panNavigationControllerGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIView *panView = self.view;
    
    static CGFloat beginX;
    CGFloat currentX = [panGestureRecognizer translationInView:panView].x;
    CGFloat percent = (currentX - beginX) / CGRectGetWidth(panView.bounds);
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractive = YES;
            beginX = [panGestureRecognizer translationInView:panView].x;
            self.myPanInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self popViewControllerAnimated:YES];
            NSLog(@"userRegisterViewController.m\n1.1\n");
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.myPanInteractiveTransition updateInteractiveTransition:percent];
            NSLog(@"userRegisterViewController.m\n1.2\n");
            break;
            
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [self.myPanInteractiveTransition finishInteractiveTransition];
                self.isInteractive = NO;
                NSLog(@"userRegisterViewController.m\n1.3\n");
            }else{
                [self.myPanInteractiveTransition cancelInteractiveTransition];
                self.isInteractive = NO;
                NSLog(@"userRegisterViewController.m\n1.4\n");
            }
            self.myPanInteractiveTransition = nil;
            NSLog(@"userRegisterViewController.m\n1.5\n");
            break;
            
        default:
            self.isInteractive = NO;
            break;
    }
}

@end
