Pod::Spec.new do |s|
  s.name             = 'PinwheelSDK'
  s.version          = '3.3.2.alpha-895d280'
  s.summary          = 'Pinwheel iOS SDK'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
  The Pinwheel SDK is used to allow end-users to manage their payroll provider settings without leaving your app. They can select their employer, authenticate with their payroll platform login credentials, and authorize direct deposit changes.
                       DESC

  s.homepage         = 'https://github.com/underdog-tech/pinwheel-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pinwheel Engineering' => 'eng@getpinwheel.com' }
  s.source           = { :git => 'https://github.com/underdog-tech/pinwheel-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.default_subspec  = 'PinwheelLinkSDK'
  s.subspec 'PinwheelLinkSDK' do |ss|
    ss.vendored_frameworks = "PinwheelSDK.xcframework"
    ss.ios.deployment_target  = '13.0'
  end
end
