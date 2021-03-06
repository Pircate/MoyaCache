
Pod::Spec.new do |s|
  s.name             = 'MoyaCache'
  s.version          = '0.3.0'
  s.summary          = 'A cache protocol for Moya.'
  s.homepage         = 'https://github.com/Pircate/MoyaCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pircate' => 'gao497868860@gmail.com' }
  s.source           = { :git => 'https://github.com/Pircate/MoyaCache.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'MoyaCache/Classes/**/*'
  s.dependency 'Moya'
  s.dependency 'Storable'
end
