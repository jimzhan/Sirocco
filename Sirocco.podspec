Pod::Spec.new do |s|
  s.name     = 'Sirocco'
  s.version  = '0.9.1'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Cocoa Addons'
  s.homepage = 'https://github.com/jimzhan/Sirocco'
  s.author   = { 'Jim Zhan'  => 'jim.zhan@me.com' }
  s.source   = { :git => 'https://github.com/jimzhan/Sirocco.git' }
  s.requires_arc = true

  s.dependency 'Nimbus'
  s.dependency 'ZUUIRevealController'
  s.dependency 'EGOTableViewPullRefresh'

  s.platform = :ios

  s.subspec 'core' do |core|
    core.source_files = 'core/src/*.{h,m}'
#    core.resource = 'core/SiroccoCore.bundle'
  end

  s.subspec 'ui' do |ui|
    ui.source_files = 'ui/src/*.{h,m}'
    ui.resource  = 'ui/SiroccoUI.bundle'
    ui.framework = 'QuartzCore'
    ui.framework = 'CoreGraphics'
  end

end
