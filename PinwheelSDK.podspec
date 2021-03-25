Pod::Spec.new do |s|
  s.name             = 'PinwheelSDK'
  s.version          = '2.2.1'
  s.summary          = 'Pinwheel iOS SDK'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
  The Pinwheel SDK is used to allow end-users to manage their payroll provider settings without leaving your app. They can select their employer, authenticate with their payroll platform login credentials, and authorize direct deposit changes.
                       DESC

  s.homepage         = 'https://github.com/underdog-tech/pinwheel-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pinwheel Engineering' => 'eng@getpinwheel.com' }
  s.source           = { :git => 'https://github.com/underdog-tech/pinwheel-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PinwheelSDK/Classes/**/*'
end
