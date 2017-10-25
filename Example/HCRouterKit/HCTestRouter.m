//
//  HCTestRouter.m
//  HCRouterKit_Example
//
//  Created by yinhaichao on 2017/10/25.
//  Copyright © 2017年 haisens@163.com. All rights reserved.
//

#import "HCTestRouter.h"
#import "HCRouterKit.h"
#import "HCViewControllerA.h"
#import "HCViewControllerB.h"
#import "HCViewControllerC.h"
#import "HCTest.h"

/*
     路由注册，项目中的路由注册统一写在一个类中（NSObject或其他），相当于hosts文件，然后把需要在模块之外被调用的类以及方法注册在里面。进而进行界面跳转和方法调用。
 */

@implementation HCTestRouter

static NSString *ROUTER_SCHEME = @"hcrouterkit";

+ (void)load {
    //注册路由scheme
    [[HCRouterKit defaultRouter] registerRouterWithScheme:ROUTER_SCHEME];
    //注册类名以及快捷类名
    [[HCRouterKit defaultRouter] registerClassQuickName:@"testhost" className:NSStringFromClass([self class])];
    //注册方法名以及快捷方法名
    [[HCRouterKit defaultRouter] registerSelectorQuickName:@"getvca" selectorName:@"getControllerA"];
    [[HCRouterKit defaultRouter] registerSelectorQuickName:@"getvcb" selectorName:@"getControllerB:"];
    [[HCRouterKit defaultRouter] registerSelectorQuickName:@"getvcc" selectorName:@"getControllerC:"];
    [[HCRouterKit defaultRouter] registerSelectorQuickName:@"gettest" selectorName:@"getTestObject:"];
}

- (UIViewController *)getControllerA {
    return [[HCViewControllerA alloc] init];
}

- (UIViewController *)getControllerB:(NSDictionary *)parameters {
    return [[HCViewControllerB alloc] initWithColor:parameters];
}

- (UIViewController *)getControllerC:(NSDictionary *)parameters {
    return [[HCViewControllerC alloc] initWithString:parameters];
}

- (void)getTestObject:(NSDictionary *)parameters {
    HCTest *test = [[HCTest alloc] init];
    [test selectorTest:parameters[@"string"]];
}

@end
