# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/workflow/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-workflow"
  spec.version       = Sidekiq::Workflow::VERSION
  spec.authors       = ["Michael Kelly"]
  spec.email         = ["michaelkelly322@gmail.com"]

  spec.summary       = "Complex workflow management in Sidekiq"
  spec.description   = "Allows the execution of mixed parallel and sequential workflows.  A workflow can be defined at runtime and executed with full sidekiq integration."
  spec.homepage      = "https://github.com/michaelkelly322/sidekiq-workflow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "sidekiq", "~> 3.3"
  spec.add_runtime_dependency "dm-types"
end
