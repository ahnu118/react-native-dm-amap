Pod::Spec.new do |s|


require 'json'
pjson = JSON.parse(File.read('package.json'))

  s.name            ="RCTGeoManager"
  s.version         = pjson["version"]
  s.homepage        = "https://github.com/ahnu118/react-native-dm-amap"
  s.summary         = pjson["description"]
  s.license         = pjson["license"]
  s.author          = { "ahnu118" => "596090355@qq.com" }
  s.ios.deployment_target = '8.0'
  s.source          = { :git => "https://github.com/ahnu118/react-native-dm-amap.git", :tag => "v#{s.version}" }
  s.source_files    = 'native-iOS/GeoModule/*.{h,m}'
  s.preserve_paths  = "**/*.js"

  s.dependency 'React/Core'

end