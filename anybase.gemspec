# frozen_string_literal: true

require_relative "lib/anybase/version"

Gem::Specification.new do |spec|
  spec.name = "anybase"
  spec.version = Anybase::VERSION
  spec.authors = ["Joshual Hull", "Brad Gessler", "Brad Lindsay"]
  spec.email = "geeks@polleverywhere.com"

  spec.summary = "Create or translate numbers from any base to any base"
  spec.description = "Create or translate numbers from any base to any base"
  spec.homepage = "https://github.com/polleverywhere/anybase"
  spec.required_ruby_version = ">= 2.0"
  spec.licenses = ["MIT"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/polleverywhere/anybase"
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
end
