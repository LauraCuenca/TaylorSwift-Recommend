# frozen_string_literal: true

require_relative "lib/ts_recommend/version"

Gem::Specification.new do |spec|
  spec.name = "ts_recommend"
  spec.version = TaylorSwiftRecommend::VERSION
  spec.authors = ["Cuenca Laura"]
  spec.email = ["laura.cuenca1@gmail.com"]

  spec.summary = "Taylor Swift song recommender based on your mood."
  spec.description = "This gem allows users to receive Taylor Swift song recommendations based on their current mood"
  spec.homepage = "https://github.com/LauraCuenca/TaylorSwift-Recommend"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/LauraCuenca/TaylorSwift-Recommend"
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "colorize", "~> 0.8.1"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
