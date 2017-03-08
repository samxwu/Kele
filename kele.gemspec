# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |s|
   s.name          = 'kele'
   s.version       = '0.0.1'
   s.date          = '2017-03-07'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Bloc API'
   s.authors       = ['Sam Wu']
   s.email         = 'sam.x.wu@gmail.com'
   s.files         = ['lib/kele.rb']
   s.require_paths = ["lib"]
   s.homepage      =
     'http://rubygems.org/gems/kele'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
   s.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'
 end