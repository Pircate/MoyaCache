
Pod::Spec.new do |s|
  s.name             = 'MoyaCache'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MoyaCache.'
  s.homepage         = 'https://github.com/Pircate/MoyaCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pircate' => 'gao497868860@gmail.com' }
  s.source           = { :git => 'https://github.com/Pircate/MoyaCache.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'MoyaCache/Classes/**/*'
  s.dependency 'Moya'
end
