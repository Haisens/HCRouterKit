# HCRouterKit

[![CI Status](http://img.shields.io/travis/haisens@163.com/HCRouterKit.svg?style=flat)](https://travis-ci.org/haisens@163.com/HCRouterKit)
[![Version](https://img.shields.io/cocoapods/v/HCRouterKit.svg?style=flat)](http://cocoapods.org/pods/HCRouterKit)
[![License](https://img.shields.io/cocoapods/l/HCRouterKit.svg?style=flat)](http://cocoapods.org/pods/HCRouterKit)
[![Platform](https://img.shields.io/cocoapods/p/HCRouterKit.svg?style=flat)](http://cocoapods.org/pods/HCRouterKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HCRouterKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HCRouterKit'
```
1、路由注册，项目中的路由注册统一写在一个类中（NSObject或其他），相当于hosts文件，然后把需要在模块之外被调用的类以及方法注册在里面。进而进行界面跳转和方法调用。
```ruby
static NSString *ROUTER_SCHEME = @"hcrouterkit";
```

```ruby
#import "HCTestRouter.h"
#import "HCRouterKit.h"
#import "HCViewController.h"
```

```ruby
//注册路由scheme
[[HCRouterKit defaultRouter] registerRouterWithScheme:ROUTER_SCHEME];
//注册类名以及快捷类名
[[HCRouterKit defaultRouter] registerClassQuickName:@"testhost" className:NSStringFromClass([self class])];
//注册方法名以及快捷方法名
[[HCRouterKit defaultRouter] registerSelectorQuickName:@"getvc" selectorName:@"getController:"];
```
2、在注册路由的类中实现获取实力对象及方法调用的方法
```ruby

- (UIViewController *)getController:(NSDictionary *)parameters {
    return [[HCViewController alloc] initWithColor:parameters];
}
```
3、在HCViewController中
```ruby
- (instancetype)initWithColor:(NSDictionary *)colorDic {
    if (self = [super init]) {
        self.view.backgroundColor = colorDic[@"color"];
    }
    return self;
}
```
```ruby
BlockSelf(blockSelf);
[[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/getvc" parameters:@{@"color":[UIColor yellowColor]} completion:^(id  _Nullable completionObject) {

    if ([completionObject isKindOfClass:[UIViewController class]]) {
        [blockSelf presentViewController:completionObject animated:YES completion:^{
            NSLog(@"\n跳转成功!\n");
        }];
    }
    
} finished:^(id  _Nullable finishedObject) {

    NSLog(@"我是finished回调的:%@", finishedObject);

}];
```
4、注意：如果是有finished回调的，需在被访问的控制器（上述中的HCViewControllerB）中遵循HCRouterKit的协议<HCRouterFinishedProtocol>，并实现回调方法。
```ruby
[self hcrouter_performFinishedBlock:@"我是finished回调"];
```

## Author

haisens@163.com, 殷海超（Groot）

## License

HCRouterKit is available under the MIT license. See the LICENSE file for more info.
