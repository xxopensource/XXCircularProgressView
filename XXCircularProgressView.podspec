#
#  Be sure to run `pod spec lint XXCircularProgressView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XXCircularProgressView"
  s.version      = "0.0.1"
  s.summary      = "A Circular Progress View of XXCircularProgressView."
  s.homepage     = "https://github.com/xxopensource/XXCircularProgressView"
  s.license      = "MIT"
  s.author             = { "SenPng" => "senpng@qq.com" }
  s.source       = { :git => "https://github.com/xxopensource/XXCircularProgressView.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"

  s.source_files  = "XXCircularProgressView"

end
