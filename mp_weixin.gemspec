# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mp_weixin/version'

Gem::Specification.new do |spec|
  spec.name          = "mp_weixin"
  spec.version       = MpWeixin::VERSION
  spec.authors       = ["jhjguxin"]
  spec.email         = ["864248765@qq.com"]
  spec.description   = %q{A wrapper for weiXin MP platform}
  spec.summary       = %q{基于 Ruby 的微信公众平台接口实现}
  spec.homepage      = "https://github.com/jhjguxin/mp_weixin"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2", [">= 0.5","<= 0.9"]
  spec.add_dependency "sinatra", "~> 1.4.4"
  spec.add_dependency "activemodel", [">= 3.0","<= 4"]
  spec.add_dependency 'multi_json', '>= 1.7.9'
  spec.add_dependency 'multi_xml', '>= 0.5.2'
  spec.add_dependency 'roxml'
  spec.add_dependency 'nestful'
  # spec.add_dependency "data_mapper", "~> 1.2.0"
  # spec.add_dependency "dm-sqlite-adapter", "~> 1.2.0"

  spec.add_development_dependency "thin"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "rake"
  # Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites
  spec.add_development_dependency 'simplecov'
  # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.
  spec.add_development_dependency 'webmock'
  # A Ruby implementation of the Coveralls API.
  spec.add_development_dependency "coveralls"
end
