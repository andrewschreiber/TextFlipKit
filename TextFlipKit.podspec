Pod::Spec.new do |s|
  s.name     = 'TextFlipKit'
  s.version  = '0.1.0'
  s.license  = 'MIT'
  s.summary  = 'A NSString & NSAttributedString category for flipping and reversing text.'
  s.homepage = 'https://github.com/andrewschreiber/TextFlipKit'
  s.author   = { 'Andrew Schreiber' => 'andrew.schreiber1@gmail.com' }
  s.source   = { :git => 'https://github.com/andrewschreiber/TextFlipKit.git', :tag => '0.1.0' }
  s.description = 'Can reverse text and/or convert each character into its upside down unicode equivalent'
  s.platform = :ios
  s.source_files = 'TextFlipKit.h', 'TextFlipKit.m'
  s.requires_arc = true
end
