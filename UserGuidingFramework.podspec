Pod::Spec.new do |spec|

  spec.name         = "UserGuidingFramework"
  spec.version      = "1.0.0"
  spec.summary      = "UserGuidingFramework testing for test."
  spec.description  = "This description is used to generate tags and improve search results."
  spec.homepage     = "http://www.rmkod.com"
  spec.license      = "BSD"
  spec.author             = { "irmakozonay" => "irmakozonay@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = '5.0'
  spec.source       = { :git => "https://github.com/irmakozonay/userguiding_fwtest.git", :tag => "1.0.0" }
  spec.source_files  = "UserGuidingFramework/**/*.{h,m,swift,xcdatamodeld}"

end
