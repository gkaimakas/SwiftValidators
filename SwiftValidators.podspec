
Pod::Spec.new do |s|
  s.name             = "SwiftValidators"
  s.version          = "1.0.8"
  s.summary          = "String validation for iOS developed in Swift. Inspired by validator.js"
  s.homepage         = "https://github.com/gkaimakas/SwiftValidators"
  s.license          = 'MIT'
  s.author           = { "gkaimakas" => "gkaimakas@gmail.com" }
  s.source           = { :git => "https://github.com/gkaimakas/SwiftValidators.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SwiftValidators/**/*'

  s.frameworks = 'Foundation'

end
