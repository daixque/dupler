# frozen_string_literal: true

require_relative "lib/dupler/version"

Gem::Specification.new do |spec|
  spec.name          = "dupler"
  spec.version       = Dupler::VERSION
  spec.authors       = ["daixque"]
  spec.email         = ["daixque@gmail.com"]

  spec.summary       = "Easy-to-use template engine driver CLI."
  spec.description   = "Dupler is a simple command line interface to generate any kind of text "\
                       "files by using template engine especially in ERB format."
  spec.homepage      = "https://github.com/daixque/dupler"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/daixque/dupler"
  spec.metadata["changelog_uri"] = "https://github.com/daixque/dupler/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.executables   = Dir.glob("./exe/*").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "activesupport"
  spec.add_dependency "hashie"
  spec.add_dependency "thor"
  spec.add_dependency "tilt"
  spec.add_dependency "yaml"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
