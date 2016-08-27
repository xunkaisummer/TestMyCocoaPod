Pod::Spec.new do |s|
  s.name             = 'podTestLibrary'
  s.version          = '0.1.0'
  s.summary          = 'Just Testing.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/xunkaisummer/TestMyCocoaPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xunkaisummmer' => 'xunkaisummmer@163.com' }
  s.source           = { :git => 'https://github.com/xunkaisummer/TestMyCocoaPod.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'podTestLibrary/Classes/**/*'
end
