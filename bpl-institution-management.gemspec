# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bpl/institution_management/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steven Anderson"]
  gem.email         = ["sanderson@bpl.org"]
  gem.description   = %q{Rails engine to do user institutions in an RDBMS for hydra-head}
  gem.summary       = %q{Rails engine to do user institutions in an RDBMS for hydra-head}
  gem.homepage      = "https://github.com/boston-library/bpl-institution-management"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bpl-institution-management"
  gem.require_paths = ["lib"]
  gem.version       = Bpl::InstitutionManagement::VERSION

  gem.add_dependency 'cancan'
  gem.add_dependency 'bootstrap_forms'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rails'
  gem.add_development_dependency 'rspec-rails'
end
