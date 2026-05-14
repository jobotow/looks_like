# frozen_string_literal: true

require_relative "lib/looks_like/version"

Gem::Specification.new do |spec|
  spec.name = "looks_like"
  spec.version = LooksLike::VERSION
  spec.authors = ["Jonathan Botchway Owusu"]
  spec.email = ["jbotchwayowusu@gmail.com"]

  spec.summary = "Detect and classify patterns in strings"
  spec.description = "A lightweight ruby library for detecting, scanning, and classifying patterns in strings."
  spec.homepage = "#{LooksLike::GITHUB}/looks_like"
  spec.required_ruby_version = ">= 3.1.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = LooksLike::GITHUB
  spec.metadata["changelog_uri"] = "#{LooksLike::GITHUB}/blob/master/CHANGELOG.md"
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
