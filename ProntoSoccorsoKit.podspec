Pod::Spec.new do |s|
    s.name             = "ProntoSoccorsoKit"
    s.version          = "0.1.0"
    s.summary          = "An iOS aggregator library for querying Italian \"Pronto Soccorso\" (A&E/ER) waiting times."
    s.description      = <<-DESC
    Use ProntoSoccorsoKit to query waiting times for Italian Pronto Soccorso.

    Check the homepage for further details about installation and usage.
    DESC

    s.homepage         = "https://github.com/Zi0P4tch0/ProntoSoccorsoKit"
    s.license          = 'MIT'
    s.author           = { "Matteo Pacini" => "matteo@codecraft.it" }
    s.source           = { :git => "https://github.com/Zi0P4tch0/ProntoSoccorsoKit.git", :tag => s.version.to_s }

    s.platform         = :ios, '12.0'

    s.source_files = 'ProntoSoccorsoKit/**/*.swift'

    s.dependency "SwiftSoup", '2.2.1'

    s.swift_versions = ['5']

end