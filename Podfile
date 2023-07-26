source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.0'
use_frameworks!

# Подключаем поды

target 'flowerz' do
  pod 'SnapKit', '5.6.0'
  pod 'Eureka'
  pod 'SwiftLint', '0.49.0'
  pod 'Swinject', '2.7.1'
end

# Для всех подов в проекте отключаем warnings и убираем изначальный DEPLOYMENT_TARGET
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
    end
  end
end