Pod::Spec.new do |s|
  s.name     = 'Sirocco'
  s.version  = '0.9.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Cocoa Addons'
  s.homepage = 'https://github.com/jimzhan/Sirocco'
  s.author   = { 'Jim Zhan'  => 'jim.zhan@me.com' }
  s.source   = { :git => 'https://github.com/jimzhan/Sirocco.git' }

  s.dependency 'Nimbus'
  s.dependency 'ZUUIRevealController'
  s.dependency 'EGOTableViewPullRefresh'

  s.platform = :ios

  s.subspec 'core' do |core|
    core.source_files = 'mods/core/src/*.{h,m}'
#    core.resource = 'mods/core/assets/SiroccoCore.bundle'
  end

  s.subspec 'ui' do |ui|
    ui.source_files = 'mods/ui/src/*.{h,m}'
    ui.resource  = 'mods/ui/assets/SiroccoUI.bundle'
    ui.framework = 'QuartzCore'
    ui.framework = 'CoreGraphics'
  end

end
