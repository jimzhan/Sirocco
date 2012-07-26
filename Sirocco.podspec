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
    core.source_files = 'apps/core/src/*.{h,m}'
  end

  s.subspec 'ui' do |ui|
    ui.source_files = 'apps/ui/src/*.{h,m}'
    ui.resource = 'apps/ui/assets/SiroccoUI.bundle'
  end

end
