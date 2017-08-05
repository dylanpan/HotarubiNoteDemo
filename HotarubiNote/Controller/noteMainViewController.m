//
//  noteMainViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "noteMainViewController.h"

@interface noteMainViewController ()

@property (strong, nonatomic) customAnimator *customAnimator;

@end

@implementation noteMainViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.customAnimator = [[customAnimator alloc] init];
        NSLog(@"noteMainViewController.m\ninit animator in navigator successed\n");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    self.isInteractive = NO;
    
    UIPanGestureRecognizer *myPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTabBarControllerGesture:)];
    [self.view addGestureRecognizer:myPanGestureRecognizer];
    NSLog(@"noteMainViewController.m\n2.0");
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tab bar controller delegate
- (id<UIViewControllerAnimatedTransitioning>) tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    if (fromIndex > toIndex){
        self.customAnimator.tabTransitionType = TabBarTransitionLeft;
        NSLog(@"noteMainViewController.m\ncall left animation\nfromIndex:%ld toIndex:%ld",(long)fromIndex,(long)toIndex);
        return self.customAnimator;
    }else{
        self.customAnimator.tabTransitionType = TabBarTransitionRight;
        NSLog(@"noteMainViewController.m\ncall right animation\nfromIndex:%ld toIndex:%ld",(long)fromIndex,(long)toIndex);
        return self.customAnimator;
    }
}

//驱动Interactive
- (id<UIViewControllerInteractiveTransitioning>) tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.isInteractive) {
        NSLog(@"noteMainViewController.m\n2.00\n");
        return self.myPanInteractiveTransition;
    }else{
        NSLog(@"noteMainViewController.m\n2.01\n");
        return nil;
    }
}

//Interactive配合
#pragma mark - Interactive
- (void) panTabBarControllerGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    NSUInteger tabBarSelectedIndex = [self selectedIndex];
    
    UIView *panView = self.view;
    static CGFloat beginX;
    CGFloat currentX = [panGestureRecognizer translationInView:panView].x;
    CGFloat percent = fabs((currentX - beginX) / CGRectGetWidth(panView.bounds));
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractive = YES;
            beginX = [panGestureRecognizer translationInView:panView].x;
            self.myPanInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (beginX > 0) {
                [self setSelectedIndex:tabBarSelectedIndex - 1];
            }else if(beginX < 0){
                [self setSelectedIndex:tabBarSelectedIndex + 1];
            }
            NSLog(@"userRegisterViewController.m\n2.1\n");
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.myPanInteractiveTransition updateInteractiveTransition:percent];
            NSLog(@"userRegisterViewController.m\n2.2\n");
            break;
            
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [self.myPanInteractiveTransition finishInteractiveTransition];
                self.isInteractive = NO;
                NSLog(@"userRegisterViewController.m\n2.3\n");
            }else{
                [self.myPanInteractiveTransition cancelInteractiveTransition];
                self.isInteractive = NO;
                NSLog(@"userRegisterViewController.m\n2.4\n");
            }
            self.myPanInteractiveTransition = nil;
            NSLog(@"userRegisterViewController.m\n2.5\n");
            break;
            
        default:
            self.isInteractive = NO;
            break;
    }
}



@end
