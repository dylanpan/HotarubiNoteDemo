//
//  newViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/5.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "newViewController.h"

@interface newViewController ()

@end

@implementation newViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myLabel.text = self.myLabelText;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"newViewController.m\nderectly call dismiss view method\n");
    
}
@end
