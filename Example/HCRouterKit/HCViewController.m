//
//  HCViewController.m
//  HCRouterKit
//
//  Created by haisens@163.com on 10/23/2017.
//  Copyright (c) 2017 haisens@163.com. All rights reserved.
//

#import "HCViewController.h"
#import "HCRouterKit.h"
#import "HCFoundation.h"

@interface HCViewController ()

@end

@implementation HCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 无参数、无返回值跳转
 
 */
- (IBAction)gotoVCA:(id)sender {
    /*方法一:*/
//    UIViewController * VCA = [HCRouterKit getControllerFromString:@"HCViewControllerA"];
//    [self presentViewController:VCA animated:YES completion:nil];
    /*方法二:*/
    BlockSelf(blockSelf);
    [[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/getvca" parameters:nil completion:^(id  _Nullable completionObject) {
        if ([completionObject isKindOfClass:[UIViewController class]]) {
            [blockSelf presentViewController:completionObject animated:YES completion:^{
                NSLog(@"\nHCViewControllerB 跳转成功!\n");
            }];
        }
    }];
}

/**
 有参数、无返回值跳转
 
 */
- (IBAction)gotoVCB:(id)sender {
    BlockSelf(blockSelf);
    [[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/getvcb" parameters:@{@"color":[UIColor yellowColor]} completion:^(id  _Nullable completionObject) {
        if ([completionObject isKindOfClass:[UIViewController class]]) {
            [blockSelf presentViewController:completionObject animated:YES completion:^{
                NSLog(@"\nHCViewControllerB 跳转成功!\n");
            }];
        }
    }];
}

/**
 有参数、有返回值跳转

 */
- (IBAction)gotoVCC:(id)sender {
    BlockSelf(blockSelf);
    [[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/getvcc" parameters:@{@"string":@"yinhaichao"} completion:^(id  _Nullable completionObject) {
        
        if ([completionObject isKindOfClass:[UIViewController class]]) {
            [blockSelf presentViewController:completionObject animated:YES completion:^{
                NSLog(@"\nHCViewControllerC 跳转成功!\n");
            }];
        }
    } finished:^(id  _Nullable finishedObject) {
        
        NSLog(@"我是finished回调的:%@", finishedObject);
        
    }];
}

/**
 普通方法调用
 
 */
- (IBAction)test:(id)sender {
    BlockSelf(blockSelf);
    [[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/gettest" parameters:@{@"string":@"yinhaichao"} completion:^(id  _Nullable completionObject) {
        if ([completionObject isKindOfClass:[UIViewController class]]) {
            [blockSelf presentViewController:completionObject animated:YES completion:^{
                NSLog(@"\nHCTest 跳转成功!\n");
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
