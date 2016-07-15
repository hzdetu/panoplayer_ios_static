Pod::Spec.new do |s|
  s.name = 'panoplayer_ios_static'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'detu panoplayer static libaray'
  s.homepage = 'https://www.detu.com'
  s.author = { 'detu' => 'https://detu.com/' }
  s.source = { :git => 'https://github.com/hzdetu/panoplayer_ios_static.git' , :tag => "1.0.0"}
  s.platform = :ios
  s.public_header_files = 'lib/include/*.{h}'
  s.source_files = 'lib/include/*.{h}','lib/IJKMediaFramework.framework','lib/libPanoPlayerStatic.a','lib/include/*.{fsh,vsh}'
  s.requires_arc  = true
  s.resources = ["lib/include/*.{fsh,vsh}"]
  s.ios.deployment_target = '7.0'
  s.preserve_paths = 'lib/IJKMediaFramework.framework','lib/libPanoPlayerStatic.a'
  s.frameworks = 'CoreGraphics', 'Foundation', 'UIkit','AVFoundation','OpenGLES','QuartzCore','CoreVideo','CoreMotion', 'CoreText', 'Security', 'CFNetwork', 'AudioToolbox', 'VideoToolbox', 'CoreMedia','IJKMediaFramework','opencv2'
  s.libraries  = 'z','xml2','c++','bz2', 'iconv','PanoPlayerStatic'
  s.vendored_library = 'lib/libPanoPlayerStatic.a'
  s.xcconfig   = { 
  'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/panoplayer_ios_static/lib/" "$(PODS_ROOT)/OpenCV/"',
  'HEADER_SEARCH_PATHS' => '/usr/include/libxml2 "$(PODS_ROOT)/panoplayer_ios_static/lib/IJKMediaFramework.framework/Headers" "$(PODS_ROOT)/OpenCV/opencv2.framework/Header"',
  'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
  'CLANG_CXX_LIBRARY' => 'libc++' }
  s.dependency  'SDWebImage', '~> 3.7'
  s.dependency  'OpenCV', '2.4.9'
end
