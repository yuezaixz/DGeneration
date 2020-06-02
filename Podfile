platform :ios, '11.0'

use_frameworks!

workspace 'DGeneration.xcworkspace'

def base_pod
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'Dollar'
  pod 'Aspects'
  pod 'SwiftDate', '~> 6.1.0'
  
end

target 'DGCore' do
  
  project 'DGCore/DGCore.xcodeproj'
  
  base_pod
  
end

target 'DGUIKit' do
  
  project 'DGUIKit/DGUIKit.xcodeproj'
  
  base_pod
  
end

# 第三方组件
def third_pod
  pod 'SnapKit', '~> 5.0.0'
  pod 'Kingfisher', '~> 5.6.0'
  pod 'IQKeyboardManagerSwift', '~> 6.4.1'
  pod 'MJRefresh'
  pod 'ActiveLabel'

  pod 'JCTagListView', '~> 2.0.0'
  pod 'JXSegmentedView'
  pod 'SkeletonView', '1.8.2'

end

def applicationPod
  base_pod
  third_pod
end

target 'DGeneration' do

  project 'DGeneration.xcodeproj'
  
  applicationPod

  # Pods for DGeneration
    

  target 'DGenerationTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DGenerationUITests' do
    # Pods for testing
  end

end
