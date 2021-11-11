Pod::Spec.new do |spec|
  spec.platform = :ios 

  spec.name         = 'SelectMenu'
  spec.version      = '0.1.0'
  spec.authors      = { 
    'Justine Wright' => 'wright.justine21@gmail.com',
  }
  spec.license      = { 
    :type => 'GNU',
    :file => 'LICENSE' 
  }
  spec.homepage     = 'https://github.com/justinewright/Select-Menu.git'
  spec.source       = { 
    :git => 'https://github.com/justinewright/Select-Menu.git', 
    :branch => 'main',
    :tag => "#{spec.version}"
  }
  spec.summary      = 'Select Menu Logic'
  spec.source_files = '**/*.swift', '*.swift'
  spec.swift_versions = '4.0'
  spec.ios.deployment_target = '12.0'
end