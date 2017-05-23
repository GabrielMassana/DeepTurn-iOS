Pod::Spec.new do |s|

  s.name         = "DeepTurn"
  s.version      = "0.1.0"
  s.summary      = "DeepTurn enables deeplinking in iOS apps."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/GabrielMassana/DeepTurn-iOS.git", :tag => s.version, :branch => "master"}
  
  s.source_files  = "DeepTurn/DeepTurn-iOS/*.swift"

  s.requires_arc = true

end

