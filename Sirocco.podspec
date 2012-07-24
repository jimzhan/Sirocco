Pod::Spec.new do |s|
  s.name     = 'Sirocco'
  s.version  = '0.9.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Cocoa Addons'
  s.homepage = 'https://github.com/jimzhan/Sirocco'
  s.author   = { 'Jim Zhan'  => 'jim.zhan@me.com' }
  s.source   = { :git => 'https://github.com/jimzhan/Sirocco.git', :commit => 'origin/master' }

  s.platform = :ios
  s.source_files = 'src/*.{h,m}', 'src/{Core,UI}/*.{h,m}'

end

