# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Draw' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

# Network
pod 'Alamofire'
pod 'Moya'
pod 'Moya/RxSwift'
#pod 'ReachabilitySwift'

# Ui
pod 'SVProgressHUD'
pod 'MBProgressHUD'
pod 'TZImagePickerController'
pod 'SnapKit', '~> 4.0.0'
#pod 'Masonry'
#pod 'MarqueeLabel/Swift'
pod 'MJRefresh'
pod 'Kingfisher'
#pod 'FLEX'
pod 'Toast'
pod 'DZNEmptyDataSet'
pod 'BetterSegmentedControl', '~> 0.9'
pod 'SDCycleScrollView'


# Rx
pod 'ReactorKit'
pod 'RxSwift'
pod 'RxCocoa'
pod 'RxDataSources'
pod 'RxOptional'
pod 'NSObject+Rx'
pod 'ReusableKit/RxSwift'
pod 'Action'

# Misc
pod 'IQKeyboardManagerSwift'
pod 'ObjectMapper'
pod 'Then'
pod 'CGFloatLiteral', '~> 0.2'
pod 'SwiftyBeaver'
pod 'LeanCloud'


  target 'DrawTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DrawUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.0'
          end
      end

end

