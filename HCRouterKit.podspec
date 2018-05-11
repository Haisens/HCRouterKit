#
# Be sure to run `pod lib lint HCRouterKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HCRouterKit'
  s.version          = '0.0.3'
  s.summary          = '简单易用的路由组件.'

  s.description      = <<-DESC
TODO: 类之间无需#import即可实现跳转，方法调用。减少代码耦合性。团队开发神器.
                       DESC

  s.homepage         = 'https://github.com/Haisens/HCRouterKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '殷海超,Groot' => 'haisens@163.com' }
  s.source           = { :git => 'https://github.com/Haisens/HCRouterKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HCRouterKit/*.{h,m}'
  
  # s.resource_bundles = {
  #   'HCRouterKit' => ['HCRouterKit/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/HCRouterKit.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'HCFoundation'
end
