Pod::Spec.new do |s|
  s.name         = "Bespohk"
  s.version      = "1.0.0"
  s.summary      = "Sugar for Objective-c."
  s.homepage     = "git@git@github.com:Bespohk/bespohk-framework-obj-c.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.authors       = { "Simon Coulton" => "simon@bespohk.com" }

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source       = { :git => "git@git@github.com:Bespohk/bespohk-framework-obj-c.git" }
  s.public_header_files = 'Bespohk/**/*.h'
  s.source_files  = [
    'Bespohk/*.h',
    'Bespohk/Caetgories/**/*.{h,m}'
  ]
end
