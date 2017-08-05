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
    // Do any additional setup after loading the view.
    
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
    if ([segue.identifier isEqualToString:@"prepareForUserTest"]) {
        NSLog(@"userRegisterRootViewController.m\nprepare for user test view finish\n");
    }else if([segue.identifier isEqualToString:@"prepareForLogin"]){
        NSLog(@"userRegisterRootViewController.m\nprepare for login view\n");
    }else{
        NSLog(@"userRegisterRootViewController.m\nprepare for nothing\n");
    }
}


- (IBAction)toLoginView:(id)sender {
}

- (IBAction)toUserTestView:(id)sender {
    //userTestViewController *toUserTestViewController = [[userTestViewController alloc] init];
    //[self.navigationController pushViewController:toUserTestViewController animated:YES];
}



@end
