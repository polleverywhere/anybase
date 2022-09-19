# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in anybase.gemspec
gemspec

major, minor, _patch = RUBY_VERSION.split(".").map(&:to_i)

gem "rake"
gem "rspec"
gem "rubocop", "<= 1.36", require: false
gem "rubocop-performance", "<= 1.15", require: false if major > 2 || (major == 2 && minor >= 2)
