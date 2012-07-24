Pod::Spec.new do |s|
  s.name            = 'Sirocco'
  s.platform        = :ios, '5.0'
  s.license         = 'Apache License, Version 2.0'
  s.summary         = 'Cocoa addons.'
  s.homepage        = 'https://github.com/jimzhan/Sirocco'
  s.dependency      = 'Nimbus'
  s.author          = { "jimzhan" => "jim.zhan@me.com" }
  s.source          = { :git => "https://github.com/jimzhan/Sirocco.git" }
  s.source_files    = 'src', 'src/**/*.{h,m}'
  s.requires_arc    = true
end
