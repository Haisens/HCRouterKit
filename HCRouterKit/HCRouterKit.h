//
//  HCRouterKit.h
//  HCRouterKit
//
//  Created by yinhaichao on 2017/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 路由执行回调

 @param completionObject 回调数据
 */
typedef void (^HCRouterCompletionBlock)(id _Nullable completionObject);

/**
 路由执行者回调（A通过路由跳转到B,B返回A时执行的回调。可用于B->A传递数据）

 @param finishedObject 回调数据
 */
typedef void (^HCRouterFinishedBlock)(id _Nullable finishedObject);

/**
 回调协议
 */
@protocol HCRouterFinishedProtocol <NSObject>

@optional
/**
 执行回调方法
 
 @param finishedObject 回调数据
 */
- (void)hcrouter_performFinishedBlock:(id)finishedObject;

@end

@interface HCRouterKit : NSObject

/**
 路由scheme是否已经注册
 */
@property (nonatomic, assign, readonly) BOOL isRegistered;
/**
 路由单利对象

 */
+ (instancetype)defaultRouter;

/**
 根据名称获取controller

 */
+ (UIViewController *)getControllerFromString:(NSString *)controllerName;

/**
 路由scheme是否已经注册

 */
- (BOOL)isRegistered;

/**
 注册路由Scheme 一个项目只拥有一个scheme

 @param scheme 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法注册App路由的唯一scheme(可取公司英文名/汉语拼音首字母);
 */
- (BOOL)registerRouterWithScheme:(NSString *)scheme;

/**
 向路由注册classQuickName(类便捷访问入口)

 @param classQuickName 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法添加一个classQuickName（类的快捷问名）;
 @param className 类名
 */
- (void)registerClassQuickName:(NSString *)classQuickName
                     className:(NSString *)className;

/**
 向路由注册selectorQuickName(方法便捷访问入口)

 @param selectorQuickName 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法添加一个selectorQuickName（类的快捷问名）;
 @param selectorName 方法名
 */
- (void)registerSelectorQuickName:(NSString *)selectorQuickName
                     selectorName:(NSString *)selectorName;

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 */
- (void)openURL:(NSString *)url;

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 @param parameters 参数
 */
- (void)openURL:(NSString *)url parameters:(NSDictionary *_Nullable)parameters;

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 @param parameters 参数
 @param completion 回调数据
 */
- (void)openURL:(NSString *)url
     parameters:(NSDictionary *_Nullable)parameters
     completion:(HCRouterCompletionBlock _Nullable)completion;

/**
 执行路由跳转

 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 @param parameters 参数
 @param completion 回调数据
 @param finished 路由执行者回调（A通过路由跳转到B,B返回A时执行的回调。可用于B->A传递数据）
 */
- (void)openURL:(NSString *)url
     parameters:(NSDictionary *_Nullable)parameters
     completion:(HCRouterCompletionBlock _Nullable)completion
       finished:(HCRouterFinishedBlock _Nullable)finished;
@end

NS_ASSUME_NONNULL_END
