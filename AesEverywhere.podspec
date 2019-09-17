Pod::Spec.new do |spec|
  spec.name         = "AesEverywhere"
  spec.module_name  = "AesEverywhere"
  spec.version      = "1.2.0"
  spec.summary      = "Swift AES256 implementation of AesEverywhere package what provides single algorithm in different programming languages"
  spec.homepage     = "https://github.com/mervick/aes-everywhere"
  spec.license      = { :type => "MIT" }
  spec.authors      = { "Andrey Izman" => "izmanw@gmail.com" }
  spec.source       = { :git => "https://github.com/mervick/aes-everywhere-swift.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/AesEverywhere/*.swift"
  spec.cocoapods_version = '>= 1.4.0'
  spec.requires_arc = true
  spec.swift_version = "5.0"
  spec.osx.deployment_target = "10.10"
  spec.ios.deployment_target = "8.0"
  spec.tvos.deployment_target = "9.0"
  spec.watchos.deployment_target = "2.0"
end
