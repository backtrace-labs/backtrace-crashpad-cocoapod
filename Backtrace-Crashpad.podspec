Pod::Spec.new do |spec|

  spec.name         = "Backtrace-Crashpad"
  spec.version      = "0.0.1"
  spec.summary      = "Binary packages for Crashpad for crash reporting, with support for special extensions including file attachments."

  spec.description  = <<-DESC
  Binary packages for Crashpad for crash reporting, with support for special extensions including file attachments.
                   DESC

  spec.homepage     = "https://github.com/backtrace-labs/backtrace-crashpad-cocoapod"
  spec.license      = {:type => 'Apache License, Version 2.0', :file => 'LICENSE'}
  spec.author             = { "Backtrace I/O" => "info@backtrace.io" }
  spec.platform     = :osx, "10.10"
  spec.source       = { :git => "https://github.com/backtrace-labs/backtrace-crashpad-cocoapod.git", :tag => "#{spec.version}" }

  spec.source_files = [
    "Sources/crashpad/**/*.h"
  ]

  spec.public_header_files = [
    "Sources/crashpad/**/*.h"
  ]

  spec.preserve_paths = [
    "Sources/crashpad/**/*.a",
    "Sources/crashpad/**/*.h",
  ]

  spec.header_mappings_dir = "Sources/crashpad"
  spec.frameworks = "CoreFoundation", "CoreGraphics", "CoreText", "IOKit", "Security"
  spec.libraries = "client", "handler", "util", "bsm", "c++", "base"
  spec.vendored_libraries = "Sources/crashpad/**/libclient.a", "Sources/crashpad/**/libhandler.a", "Sources/crashpad/**/libutil.a", "Sources/crashpad/**/libbase.a"
  spec.resources = [
    "Sources/crashpad/out/Default/crashpad_handler",
    "Sources/crashpad/out/Default/crashpad_database_util",
  ]
  spec.xcconfig = {
    'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/Headers/Public/Backtrace-Crashpad/third_party/mini_chromium/mini_chromium"'
  }

end
