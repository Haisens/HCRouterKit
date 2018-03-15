//
//  HCViewControllerC.m
//  HCRouterKit_Example
//
//  Created by yinhaichao on 2017/10/25.
//  Copyright © 2017年 haisens@163.com. All rights reserved.
//

#import "HCViewControllerC.h"
#import "HCRouterKit.h"

@interface HCViewControllerC ()<HCRouterFinishedProtocol>
{
    NSDictionary *_strDic;
    
}
@end

@implementation HCViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backButtonClicked:(id)sender {
    [self hcrouter_performFinishedBlock:@"我是finished回调"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype)initWithString:(NSDictionary *)strDic {
    if (self = [super init]) {
        _strDic = strDic;
    }
    return self;
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
