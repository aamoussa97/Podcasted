platform :ios, '13'

def common_pods
  use_frameworks!  
  pod 'Alamofire', '~> 5.0.0-rc.2'
  pod 'SwiftyJSON', '~> 5.0.0'
  pod 'SPAlert'
  pod 'SDWebImage', '~> 5.1.1'
  pod "TinyConstraints"
  pod 'SwiftIcons', '~> 2.3.2'
  pod 'BottomPopup'
  pod 'AFDateHelper', '~> 4.3.0'
  pod 'SwiftyFORM', :git => 'https://github.com/neoneye/SwiftyFORM.git', :commit => 'c2b9071acc952910629bd9a471c50f41ae5ad6a3'
end

target 'Podcasted' do
  common_pods
end

target 'PodcastedNeoUITests' do
  common_pods
end

target 'PodcastedNeoUnitTests' do
  common_pods
end