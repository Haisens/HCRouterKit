Pod::Spec.new do |s|
  s.name = "HCRouterKit"
  s.version = "0.0.2"
  s.summary = "\u7B80\u5355\u6613\u7528\u7684\u8DEF\u7531\u7EC4\u4EF6."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"殷海超,Groot"=>"haisens@163.com"}
  s.homepage = "https://github.com/Haisens/HCRouterKit"
  s.description = "TODO: \u7C7B\u4E4B\u95F4\u65E0\u9700#import\u5373\u53EF\u5B9E\u73B0\u8DF3\u8F6C\uFF0C\u65B9\u6CD5\u8C03\u7528\u3002\u51CF\u5C11\u4EE3\u7801\u8026\u5408\u6027\u3002\u56E2\u961F\u5F00\u53D1\u795E\u5668."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/HCRouterKit.framework'
end
