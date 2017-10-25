//
//  HCViewControllerB.m
//  HCRouterKit_Example
//
//  Created by yinhaichao on 2017/10/25.
//  Copyright © 2017年 haisens@163.com. All rights reserved.
//

#import "HCViewControllerB.h"

@interface HCViewControllerB ()

@end

@implementation HCViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithColor:(NSDictionary *)colorDic {
    if (self = [super init]) {
        self.view.backgroundColor = colorDic[@"color"];
    }
    return self;
}
- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
