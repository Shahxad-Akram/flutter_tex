#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_tex'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to render Tex - Latex to render Maths,  Physics and Chemistry equations mainly based on MathJax'
  s.description      = <<-DESC
A Flutter plugin to render Tex - Latex to render Maths,  Physics and Chemistry equations mainly based on MathJax
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

