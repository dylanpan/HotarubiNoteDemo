//
//  userRegisterRootViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/10.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "userRegisterRootViewController.h"

@interface userRegisterRootViewController ()

@end

@implementation userRegisterRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coreDataManager *myCoreDataManager = [coreDataManager shareCoreDataManager];
    self.userMOC = myCoreDataManager.managedObjectContext;
    
    self.TestButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"prepareForUserTest"]) {
        NSLog(@"userRegisterRootViewController.m\nprepare for user test view finish\n");
    }else if([segue.identifier isEqualToString:@"prepareForLogin"]){
        NSLog(@"userRegisterRootViewController.m\nprepare for login view\n");
    }else{
        NSLog(@"userRegisterRootViewController.m\nprepare for nothing\n");
    }
}

#pragma mark - button action
- (IBAction)toLoginView:(id)sender {
    [self performSegueWithIdentifier:@"prepareForLogin" sender:self];
}

- (IBAction)toUserTestView:(id)sender {
    
}

- (IBAction)toMainOneView:(id)sender {
    NSFetchRequest *searchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error = nil;
    __weak userRegisterRootViewController *weakSelf = self;
    NSArray *userExistArray = [self.userMOC executeFetchRequest:searchRequest error:&error];
    if (userExistArray == nil) {
        NSLog(@"empty");
    }else{
        NSLog(@"not empty:%lu",(unsigned long)[userExistArray count]);
    }
    if ((![self.userNameTextField.text isEqualToString:@""]) && (![self.userNewPasswordTextField.text isEqualToString:@""]) && (![self.userNewPasswordComfirmTextField.text isEqualToString:@""])) {
        NSLog(@"text field did not empty");
        [userExistArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            User *matchUser = (User *)obj;
            if ([weakSelf.userNameTextField.text isEqualToString:matchUser.userName]) {
                NSLog(@"user name : %@",matchUser.userName);
                NSString *message = [NSString stringWithFormat:@"User name already exist"];
                [weakSelf showWarningAlert:message];
                *stop = YES;
            }
        }];
        if ([self checkUserName:self.userNameTextField.text]) {
            if ([self checkPassword:self.userNewPasswordTextField.text]) {
                if ([self.userNewPasswordTextField.text isEqualToString:self.userNewPasswordComfirmTextField.text]) {
                    self.user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.userMOC];
                    self.user.userName = self.userNameTextField.text;
                    self.user.userPassword = self.userNewPasswordComfirmTextField.text;
                    NSError *error = nil;
                    if (self.userMOC.hasChanges) {
                        [self.userMOC save:&error];
                    }
                    if (error) {
                        NSLog(@"HotarubiNoteViewController.m\nadd user error : %@",error);
                    }
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    noteMainViewController *noteViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"noteTabBarController"];
                    [self presentViewController:noteViewController animated:YES completion:nil];
                }else{
                    NSString *message = [NSString stringWithFormat:@"Password comfirm was inconformity"];
                    [self showWarningAlert:message];
                }
            }else{
                NSString *message = [NSString stringWithFormat:@"Password did not comniation of letters and numbers"];
                [self showWarningAlert:message];
            }
        }else{
            NSString *message = [NSString stringWithFormat:@"User name did not pure letter"];
            [self showWarningAlert:message];
        }
    }else if ([self.userNameTextField.text isEqualToString:@""]) {
        NSString *message = [NSString stringWithFormat:@"User name did not input"];
        [self showWarningAlert:message];
    }else if ([self.userNewPasswordTextField.text isEqualToString:@""]) {
        NSString *message = [NSString stringWithFormat:@"password did not input"];
        [self showWarningAlert:message];
    }else if ([self.userNewPasswordComfirmTextField.text isEqualToString:@""]) {
        NSString *message = [NSString stringWithFormat:@"password confirm did not input"];
        [self showWarningAlert:message];
    }
}

- (void) showWarningAlert:(NSString *)paramMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"WARNING" message:paramMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click OKAction");
    }];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//判断user name是否为纯字母
- (BOOL) checkUserName:(NSString *)paramUserName{
    //去掉所有的空格
    paramUserName = [paramUserName stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //筛选数字条件
    NSRegularExpression *numberRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //获取字符串中含有数字的个数
    NSInteger numberMatchCount = [numberRegularExpression numberOfMatchesInString:paramUserName options:NSMatchingReportProgress range:NSMakeRange(0, paramUserName.length)];
    
    if (numberMatchCount == paramUserName.length) {
        //纯数字
        return NO;
    }
    
    //筛选字母条件
    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //获取字符串中含有字母的个数
    NSInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:paramUserName options:NSMatchingReportProgress range:NSMakeRange(0, paramUserName.length)];
    
    if (letterMatchCount == paramUserName.length) {
        //纯字母
        return YES;
    }
    
    if ((numberMatchCount + letterMatchCount) == paramUserName.length) {
        //字母与数字组合
        return NO;
    }else{
        //包含字母和数字之外的字符
        return NO;
    }
}

//判断passord是否为英文与数字组合
- (BOOL) checkPassword:(NSString *)paramPassword{
    //去掉所有的空格
    paramPassword = [paramPassword stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //筛选数字条件
    NSRegularExpression *numberRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //获取字符串中含有数字的个数
    NSInteger numberMatchCount = [numberRegularExpression numberOfMatchesInString:paramPassword options:NSMatchingReportProgress range:NSMakeRange(0, paramPassword.length)];
    
    if (numberMatchCount == paramPassword.length) {
        //纯数字
        return NO;
    }
    
    //筛选字母条件
    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //获取字符串中含有字母的个数
    NSInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:paramPassword options:NSMatchingReportProgress range:NSMakeRange(0, paramPassword.length)];
    
    if (letterMatchCount == paramPassword.length) {
        //纯字母
        return NO;
    }
    
    if ((numberMatchCount + letterMatchCount) == paramPassword.length) {
        //字母与数字组合
        return YES;
    }else{
        //包含字母和数字之外的字符
        return NO;
    }
}


#pragma mark - keyboard exit
//点击return后触发，隐藏键盘
- (IBAction)userNameTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [self.userNewPasswordTextField becomeFirstResponder];
}
- (IBAction)userPasswordTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [self.userNewPasswordComfirmTextField becomeFirstResponder];
}

- (IBAction)userPasswordComfirmTextField_DidEndOnExit:(id)sender{
    //焦点移至下一个输入框
    [sender resignFirstResponder];
    [self toMainOneView:self];
}

//点击view的空白处后触发，隐藏键盘
- (IBAction)UIView_TouchDown:(id)sender{
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
