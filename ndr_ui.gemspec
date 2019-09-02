# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'ndr_ui/version'

unless Gem::Version.new(Gem::VERSION) >= Gem::Version.new('3.0.2')
  # See https://github.com/rubygems/rubygems/pull/2516 for details
  raise 'Please update RubyGems to at least 3.0.2 - lower versions build a broken ndr_ui.gem!'
end

Gem::Specification.new do |spec|
  spec.name          = 'ndr_ui'
  spec.version       = NdrUi::VERSION
  spec.authors       = ['NDR Development Team']
  spec.email         = []
  spec.summary       = 'NDR UI Rails Engine'
  spec.description   = 'Provides Rails applications with additional support for the ' \
                       'Twitter Bootstrap UI framework'
  spec.homepage      = 'https://github.com/PublicHealthEngland/ndr_ui'
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,lib,vendor}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md'] - ['.travis.yml']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_dependency 'rails', '>= 5.1', '< 7.0'
  spec.add_dependency 'bootstrap-sass', '~> 3.4.1'
  spec.add_dependency 'sass-rails', '>= 3.2'
  spec.add_dependency 'jquery-rails', '>= 4.1.0'

  spec.add_development_dependency 'sqlite3'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'ndr_dev_support', '>= 5.4.5'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'mocha', '~> 1.1.0'
end
