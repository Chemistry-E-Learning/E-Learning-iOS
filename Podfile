# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'ChemistryAR' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChemistryAR
pod 'Swinject'
pod 'Alamofire'
pod 'lottie-ios', '~>3.5.0'
pod 'Firebase/Crashlytics', '~> 9.6.0'
pod 'Firebase/AnalyticsWithoutAdIdSupport', '~> 9.6.0'
pod 'Firebase/Messaging', '~> 9.6.0'
target :ChemistryARTests
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
      elsif config.name == 'Test'
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'TEST'
      elsif config.name == 'Staging'
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'STAGING'
      elsif config.name == 'Prerelease'
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'PRERELEASE'
      elsif config.name == 'Release'
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'RELEASE'
      end
    end
  end
end
