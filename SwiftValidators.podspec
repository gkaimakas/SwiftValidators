#
# Be sure to run `pod lib lint SwiftValidators.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SwiftValidators"
  s.version          = "1.0.0"
  s.summary          = "String validation for iOS developed in Swift. Inspired by validator.js"
  s.description      = <<-DESC
                        "String validation for iOS developed in Swift. Inspired by validator.js"
                       DESC
  s.homepage         = "https://github.com/gkaimakas/SwiftValidators"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "gkaimakas" => "gkaimakas@gmail.com" }
  s.source           = { :git => "https://github.com/gkaimakas/SwiftValidators.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SwiftValidators/**/*'
  s.resource_bundles = {
    'SwiftValidators' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
