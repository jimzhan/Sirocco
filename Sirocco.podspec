Pod::Spec.new do |s|
  s.name    = 'Sirocco'
  s.version = '0.9.0'
  s.license = 'Apache License, Version 2.0'
  s.summary = 'Cocoa Addons'
  s.homepage= 'https://github.com/jimzhan/Sirocco'
  s.author  = { 'Jim Zhan'  => 'jim.zhan@me.com' }
  s.source  = { :git => 'https://github.com/jimzhan/Sirocco.git', :commit => 'origin/master' }
  s.platform     = :ios

  s.subspec 'Core' do |core|
    core.source_files = 'src/Core'
  end

  s.subspec 'UI' do |ui|
    ui.source_files = 'src/UI'
    ui.dependency 'Sirocco/Core'
  end

end

