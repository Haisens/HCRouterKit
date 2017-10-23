//
//  HCRouterKit.h
//  HCRouterKit
//
//  Created by yinhaichao on 2017/10/23.
//

#import <Foundation/Foundation.h>

@interface HCRouterKit : NSObject

/**
 路由单利对象

 */
+ (instancetype)defaultRouter;

/**
 根据名称获取controller

 */
+ (UIViewController *)getControllerFromString:(NSString *)controllerName;
@end
