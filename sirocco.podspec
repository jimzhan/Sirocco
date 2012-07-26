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

  s.platform = :ios
#  s.source_files = 'src/*.{h,m}', 'src/{Core,UI}/*.{h,m}'

  s.subspec 'Core' do |core|
    core.source_files = 'src/core/src'
  end

  s.subspec 'UI' DO |ui|
    ui.source_files = 'src/ui/src'
    ui.dependency 'Sirocco/Core'
    ui.resource = 'src/ui/assets/SiroccoUI.bundle'
  end
end
