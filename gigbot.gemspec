# frozen_string_literal: true

require_relative "lib/gigbot/version"

Gem::Specification.new do |spec|
  spec.name = "gigbot"
  spec.version = Gigbot::VERSION
  spec.authors = ["Teejay VanSlyke"]
  spec.email = ["root@teejayvanslyke.com"]

  spec.summary = "Git-inspired remote tech job aggregator for the command line"
  spec.homepage = "https://github.com/teejayvanslyke/gigbot"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables << "gigbot"
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "thor"
  spec.add_dependency "rss"
  spec.add_dependency "feedjira"
  spec.add_dependency "colorize"
  spec.add_dependency "ferrum"
  spec.add_dependency "tty-pager"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
