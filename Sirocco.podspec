Pod::Spec.new do |s|
  s.name         = "Sirocco"
  s.version      = "0.9.0"
  s.summary      = "Cocoa addons."
  s.homepage     = "https://github.com/jimzhan/Sirocco"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "jimzhan" => "jim.zhan@me.com" }
  #
  s.source       = { :git => "https://github.com/jimzhan/Sirocco.git", :tag => "0.9.0" }
  # s.description  = <<-DESC
  #                   An optional longer description of Sirocco
  #
  #                   * Markdonw format.
  #                   * Don't worry about the indent, we strip it!
  #                  DESC
  
  s.platform     = :ios, '5.0'

  s.source_files = 'src', 'src/**/*.{h,m}'
  # s.libraries = 'iconv', 'xml2'
  s.requires_arc = true
end
