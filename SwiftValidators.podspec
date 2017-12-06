
Pod::Spec.new do |s|
  s.name             = "SwiftValidators"
  s.version          = "7.0.3"
  s.summary          = "String validation for iOS developed in Swift"
  s.homepage         = "https://github.com/gkaimakas/SwiftValidators"
  s.license          = 'MIT'
  s.author           = { "gkaimakas" => "gkaimakas@gmail.com" }
  s.source           = { :git => "https://github.com/gkaimakas/SwiftValidators.git", :tag => s.version }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*.swift'

  s.frameworks = 'Foundation'

end
