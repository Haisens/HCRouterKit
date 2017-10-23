//
//  HCRouterKit.m
//  HCRouterKit
//
//  Created by yinhaichao on 2017/10/23.
//

#import "HCRouterKit.h"

@implementation HCRouterKit

/**
 路由单利对象
 
 */
+ (instancetype)defaultRouter {
    static HCRouterKit *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[HCRouterKit alloc] init];
    });
    return router;
}

/**
 根据名称获取controller
 
 */
+ (UIViewController *)getControllerFromString:(NSString *)controllerName {
    if ([controllerName length]) {
        id controller = [NSClassFromString(controllerName) new];
        if (![controller isKindOfClass:[UIViewController class]]) {
            
        }
        return controller;
    }
    return nil;
}


@end
