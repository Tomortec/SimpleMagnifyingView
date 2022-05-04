#
# Be sure to run `pod lib lint SimpleMagnifyingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleMagnifyingView'
  s.version          = '0.1.0'
  s.summary          = '`SimpleMagnifyingView` is a SwiftUI view which can create a magnifier.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  `SimpleMagnifyingView` is a SwiftUI view which can create a magnifier with only a few lines.
  You can customize the shape and the scale of the magnifier easily.
  This view is truly useful for accessiblity.
                       DESC

  s.homepage         = 'https://github.com/Tomortec/SimpleMagnifyingView'
   s.screenshots     = './screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tomortec' => 'everything@tomortec.com' }
  s.source           = { :git => 'https://github.com/Tomortec/SimpleMagnifyingView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'

  s.source_files = 'SimpleMagnifyingView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SimpleMagnifyingView' => ['SimpleMagnifyingView/Assets/*.png']
  # }
end
