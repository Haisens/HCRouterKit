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
```ruby
//注册路由scheme
[[HCRouterKit defaultRouter] registerRouterWithScheme:@"scheme"];
//注册类名以及快捷类名
[[HCRouterKit defaultRouter] registerClassQuickName:@"testhost" className:@"class"];
//注册方法名以及快捷方法名
[[HCRouterKit defaultRouter] registerSelectorQuickName:@"getvca" selectorName:@"selector"];

BlockSelf(blockSelf);
[[HCRouterKit defaultRouter] openURL:@"hcrouterkit://testhost/getvcc" parameters:@{@"string":@"yinhaichao"} completion:^(id  _Nullable completionObject) {

    if ([completionObject isKindOfClass:[UIViewController class]]) {
        [blockSelf presentViewController:completionObject animated:YES completion:^{
        NSLog(@"\n跳转成功!\n");
    }];
    }
} finished:^(id  _Nullable finishedObject) {

    NSLog(@"我是finished回调的:%@", finishedObject);

}];
```

## Author

haisens@163.com, 殷海超（Groot）

## License

HCRouterKit is available under the MIT license. See the LICENSE file for more info.
