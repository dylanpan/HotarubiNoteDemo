//
//  HotarubiNoteViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/4.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "HotarubiNoteViewController.h"


@interface HotarubiNoteViewController () <secondViewControllerDelegate>

@property (strong, nonatomic) customAnimator *customAnimator;

@end

@implementation HotarubiNoteViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.customAnimator = [[customAnimator alloc] init];
        NSLog(@"HotarubiNoteViewController.m\ninit animator successed\n");
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toSecondViewButton.hidden = YES;
    self.toNewOneButton.hidden = YES;
    self.toNewTwoButton.hidden = YES;
    
    NSLog(@"HotarubiNoteViewController.m\nview did load\n");
    NSLog(@"frame\nw:%f\nh:%f\n",self.view.frame.size.width,self.view.frame.size.height);
    NSLog(@"bounds\nw:%f\nh:%f\n",self.view.bounds.size.width,self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard exit
- (IBAction)TextField_DidEndOnExit:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)View_TouchDown:(id)sender{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}


#pragma mark - segue transition
- (IBAction)userLogin:(id)sender {
    
}

- (IBAction)userRegister:(id)sender {
    
}

#pragma mark - no segue transition
//未在storyboard中设置两个viewController之间的segue，即segue不存在，手工进行场景转换
- (IBAction)toNew:(id)sender {
    //方法一：使用storyboard中的identifierID获取destination view controller，后续显示均正确
    //跳转成功。触发动画，目标视图有控件
    //获取storyboard的实例
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取目标viewController的实例，必须在storyboard的右侧标明【storyboard ID】
    //newViewController *toNewViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"newViewController"];
    
    //方法二：没有storyboard进行连线会存在问题，动画结束后没有正确展示destination view
    //跳转成功。触发动画，目标视图没有控件
    newViewController *toNewViewController = [[newViewController alloc] init];
    
    //设置代理
    toNewViewController.transitioningDelegate = self;
    //设置view的display为modal，以及相应的style
    toNewViewController.modalPresentationStyle = UIModalPresentationCustom;
    //设置label属性值
    [toNewViewController setValue:@"xoxoxoxoxo" forKey:@"myLabelText"];
    //显示目标viewController对应的view
    [self presentViewController:toNewViewController
                       animated:YES
                     completion:^(void){
                         NSLog(@"HotarubiNoteViewController.m\nto new view present animation complete\n");
                     }];
    //补充：在storyboard中已经设置两个viewController之间的segue，即segue存在，VC to VC的实现需要通过在代码中调用方法【performSegueWithIdentifier:sender:】，比如一个消息msg来了，然后进行转场
     
    NSLog(@"HotarubiNoteViewController.m\nto new view\n");
}


- (IBAction)toSecondView:(id)sender {
    
}


- (IBAction)toNewTwo:(id)sender {
    //在storyboard进行连线，动画结束后展示destination view，但设置各种属性放在IBAction中都无法实现
    newViewController *toNewViewController = [[newViewController alloc] init];
    
    //设置代理-在prepareForSegue中实现，否则不调用动画
    toNewViewController.transitioningDelegate = self;
    //设置view的display为modal，以及相应的style
    toNewViewController.modalPresentationStyle = UIModalPresentationCustom;
    //设置label属性值-在prepareForSegue中实现，否则传值不成功
    [toNewViewController setValue:@"yoyoyoyoyo" forKey:@"myLabelText"];
    
    //显示目标viewController对应的view
    [self presentViewController:toNewViewController
                       animated:YES
                     completion:^(void){
                         NSLog(@"HotarubiNoteViewController.m\nto new two view present animation complete\n");
                     }];
    
    NSLog(@"HotarubiNoteViewController.m\nto new two view\n");
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"toSecondView"]){
         //获取目标ViewController
         secondViewController *toSecondController = [segue destinationViewController];
         
         //设置代理-用于实现调用dismiss方法
         toSecondController.secondDelegate = self;
         //设置代理-用于实现调用animateTransition方法
         toSecondController.transitioningDelegate = self;
         //modal的custom模式没有除去fromViewController，fullscreen模式会除去fromViewController
         toSecondController.modalPresentationStyle = UIModalPresentationCustom;
         
         //属性传值
         toSecondController.secondLabelText = @"momomomomo";
         
         //KVC传值
         UIViewController *toSecondTwoController = [segue destinationViewController];
         [toSecondTwoController setValue:@"ouououou" forKey:@"secondLabelTwoText"];
         
         NSLog(@"HotarubiNoteViewController.m\nprepare for second view finish\n");
     }else if ([segue.identifier isEqualToString:@"prepareForUserRegister"]) {
         userRegisterViewController *toUserRegisterViewController = [segue destinationViewController];
         //设置代理-用于实现调用animateTransition方法
         toUserRegisterViewController.transitioningDelegate = self;
         //modal的custom模式没有除去fromViewController，fullscreen模式会除去fromViewController
         toUserRegisterViewController.modalPresentationStyle = UIModalPresentationFullScreen;
         NSLog(@"HotarubiNoteViewController.m\nprepare for Register Root View finish\n");
     }else if ([segue.identifier isEqualToString:@"prepareForUserLogin"]){
         UIViewController *noteMainViewController = [segue destinationViewController];
         [noteMainViewController setValue:self.typeInUserName.text forKey:@"userName"];
         [noteMainViewController setValue:self.typeInUserPassword.text forKey:@"userPassword"];
         NSLog(@"HotarubiNoteViewController.m\nprepare for main view finish\n");
     }else{
         //UIViewController *toNewViewController = [segue destinationViewController];
         //[toNewViewController setValue:@"yoyoyoyoyo" forKey:@"myLabelText"];
         //toNewViewController.transitioningDelegate = self;
         //toNewViewController.modalPresentationStyle = UIModalPresentationCustom;
         NSLog(@"HotarubiNoteViewController.m\nprepare for nothing\n");
     }
 }

#pragma mark - KVC undefine method
- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"HotarubiNoteViewController.m\nno value no key\n");
}

- (id) valueForUndefinedKey:(NSString *)key{
    NSLog(@"HotarubiNoteViewController.m\nno key\n");
    return nil;
}

#pragma mark - modal transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    NSLog(@"HotarubiNoteViewController.m\nmodal present transition delegate\n");
    return self.customAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSLog(@"HotarubiNoteViewController.m\nmodal dismiss transition delegate\n");
    return self.customAnimator;
}
    
    
#pragma mark - secondViewControllerDelegate dismiss method
- (void) dismissPresentedViewController:(secondViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"HotarubiNoteViewController.m\ncall second view dismiss delegate dismiss method\n");
}


@end
     
