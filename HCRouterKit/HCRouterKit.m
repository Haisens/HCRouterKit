//
//  HCRouterKit.m
//  HCRouterKit
//
//  Created by yinhaichao on 2017/10/23.
//

#import "HCRouterKit.h"
#import "HCFoundation.h"
#import <objc/runtime.h>

@implementation HCRouterKit
{
    @private
    NSMutableDictionary *_HCRouterClassList;
    @private
    NSMutableDictionary *_HCRouterSelectorList;
    @private
    NSString     *_HCRouterScheme;
}
@synthesize isRegistered = _isRegistered;
/**
 路由单利对象
 
 */
+ (instancetype )defaultRouter {
    static HCRouterKit *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[HCRouterKit alloc] init];
    });
    return router;
}

/**
 初始化

 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _HCRouterClassList = [NSMutableDictionary dictionary];
        _HCRouterSelectorList = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 根据名称获取controller
 
 */
+ (UIViewController *)getControllerFromString:(NSString *)controllerName {
    if ([controllerName length]) {
        id controller = [NSClassFromString(controllerName) new];
        if (![controller isKindOfClass:[UIViewController class]]) {
            NSAssert([controller isKindOfClass:[UIViewController class]], @"没有找到对应的controller!");
        }
        return controller;
    }
    return nil;
}

- (BOOL)isRegistered {
    return self.isRegistered;
}

/**
 注册路由Scheme 一个项目只拥有一个scheme
 
 @param scheme 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法注册App路由的唯一scheme(可取公司英文名/汉语拼音首字母);
 */
- (BOOL)registerRouterWithScheme:(NSString *)scheme {
    if (!_isRegistered) {
        NSAssert([scheme length], @"参数[scheme]格式不对，长度必须大于0");
        _HCRouterScheme = scheme;
        _isRegistered = YES;
    }
    return NO;
}

/**
 向路由注册快捷类名classQuickName
 
 @param classQuickName 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法添加一个classQuickName（类的快捷问名）;
 @param className 对应的类名
 */
- (void)registerClassQuickName:(NSString *)classQuickName
                     className:(NSString *)className {
    NSAssert([classQuickName length], @"参数[classQuickName]格式不对，长度必须大于0");
    NSAssert([className length], @"参数[className]格式不对，长度必须大于0");
    [_HCRouterClassList setObject:className forKey:classQuickName];
}

/**
 向路由注册快捷方法名selectorQuickName
 
 @param selectorQuickName 路由以scheme://classQuickName/selectorQuickName/为地址,objects为参数跳转,此方法添加一个selectorQuickName（类的快捷问名）;
 @param selectorName 方法名
 */
- (void)registerSelectorQuickName:(NSString *)selectorQuickName selectorName:(NSString *)selectorName {
    NSAssert([selectorQuickName length], @"参数[selectorQuickName]格式不对，长度必须大于0");
    NSAssert([selectorName length], @"参数[selectorName]格式不对，长度必须大于0");
    [_HCRouterSelectorList setObject:selectorName forKey:selectorQuickName];
    
}

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 */
- (void)openURL:(NSString *)url {
    [self openURL:url parameters:nil completion:nil finished:nil];
}

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 @param parameters 参数
 */
- (void)openURL:(NSString *)url parameters:(NSDictionary *_Nullable)parameters {
    [self openURL:url parameters:parameters completion:nil finished:nil];
}

/**
 执行路由跳转
 
 @param url 路由地址 scheme://classQuickName/selectorQuickName/
 @param parameters 参数
 @param completion 回调数据
 */
- (void)openURL:(NSString *)url
     parameters:(NSDictionary *_Nullable)parameters
     completion:(HCRouterCompletionBlock _Nullable)completion {
    [self openURL:url parameters:parameters completion:completion finished:nil];
}

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
       finished:(HCRouterFinishedBlock _Nullable)finished {
    
    if (![url containsString:@"://"]) {
        if (completion) {
            completion([HCRouterKit getControllerFromString:url]);
        }
        return;
    }
    
    if (!_isRegistered) {
        HCLog(@"router未注册!");
        if (completion) {
            completion([NSString stringWithFormat:@"\n%s ------ router未注册!\n", __func__]);
        }
        if (finished) {
            finished([NSString stringWithFormat:@"\n%s ------ router未注册!\n", __func__]);
        }
        return;
    }
    
    NSURL *routerURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (![routerURL.scheme isEqualToString:_HCRouterScheme]) {
        HCLog(@"scheme不正确!");
        if (completion) {
            completion([NSString stringWithFormat:@"\n%s ------ scheme不正确!\n", __func__]);
        }
        if (finished) {
            finished([NSString stringWithFormat:@"\n%s ------ scheme不正确!\n", __func__]);
        }
        return;
    }
    
    NSMutableDictionary *realParameters = [parameters mutableCopy];
    if (!realParameters) {
        realParameters = [[NSMutableDictionary alloc] init];
    }
    
    NSString *URLQuery = [[routerURL query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    /** 获取url请求参数 */

    for (NSString *urlParameter in [URLQuery componentsSeparatedByString:@"&"]) {
        NSArray *elements = [urlParameter componentsSeparatedByString:@"="];
        if([elements count] < 2) continue;
        [realParameters setObject:[elements lastObject] forKey:[elements firstObject]];
    }
    
    /** 获取Url解析的Class名称 */
    NSString *className = [routerURL.host stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    /** 获取url解析的Selector名称 */
    NSString *selectorName = [routerURL.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    id completionObject = [self performClass:className
                                    selector:selectorName
                                  parameters:realParameters];
    
    if (finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([completionObject respondsToSelector:@selector(hcrouter_addFinishedCompletionBlock:)]) {
            [completionObject performSelector:@selector(hcrouter_addFinishedCompletionBlock:) withObject:finished];
        }
#pragma clang diagnostic pop
    }
    
    if (completion) {
        completion(completionObject);
    }
}

/**
 判断方法是否可以正确执行

 @param classNamePoint 快捷类名
 @param selectorNamePoint 快捷方法名
 @param error 错误信息
 */
- (BOOL)canPerformClass:(inout NSString **)classNamePoint
               selector:(inout NSString **)selectorNamePoint
                  error:(inout NSError **)error {
    NSString *className = * classNamePoint;
    NSString *selectorName = * selectorNamePoint;
    
    //获取类名、方法名
    if ([_HCRouterClassList.allKeys containsObject:className]) {
        className = _HCRouterClassList[className];
    }
    if ([_HCRouterSelectorList.allKeys containsObject:selectorName]) {
        selectorName = _HCRouterSelectorList[selectorName];
    }
    
    * classNamePoint = className;
    * selectorNamePoint = selectorName;
    
    NSLog(@"\n类名 : %@\n方法名 : %@\n", className, selectorName);
    //获取类
    Class targetClass = NSClassFromString(className);
    //获取类的实例对象
    id target = [[targetClass alloc] init];
    if (!target) {
        if (error) {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"【%@】Class不正确!", className]
                                         code:404
                                     userInfo:nil];
        }
        return NO;
    }
    //获取类的实例方法
    SEL selector = NSSelectorFromString(selectorName);
    
    if (![target respondsToSelector:selector]) {
        if (error) {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"【%@】 Selector不正确!", selectorName]
                                         code:404
                                     userInfo:nil];
        }
        return NO;
    }
    return YES;
}

/**
 本地组件调用入口
 
 @param className       组件类名称
 @param selectorName      组件方法名
 @param parameters      方法参数
 
 @return 实例对象
 */
- (id)performClass:(NSString *)className
          selector:(NSString *)selectorName
        parameters:(NSDictionary *)parameters {
    
    NSError *error;
    [self canPerformClass:&className selector:&selectorName error:&error];
    NSLog(@"参数: %@", parameters);
    if (error) {
        return nil;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        //执行方法
        return [[[NSClassFromString(className) alloc] init] performSelector:NSSelectorFromString(selectorName) withObject:parameters];
#pragma clang diagnostic pop
        
    }
}

@end



@implementation NSObject (HCRouterExtension)

static const char HCRouterFinishedBlockRuntimeKey;

/**
 通过runtime动态添加回调方法

 */
- (void)hcrouter_addFinishedCompletionBlock:(HCRouterFinishedBlock)finishedBlock {
    objc_setAssociatedObject(self, &HCRouterFinishedBlockRuntimeKey, finishedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 执行回调方法

 @param finishedObject 回调数据
 */
- (void)hcrouter_performFinishedBlock:(id)finishedObject {
    HCRouterFinishedBlock finished = objc_getAssociatedObject(self, &HCRouterFinishedBlockRuntimeKey);
    if (finished) {
        finished(finishedObject);
    }
}

@end
