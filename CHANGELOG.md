# Changelog

This file tracks the notable changes made to this project. It is meant for humans to read,
and is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## Unreleased

[Unreleased commits](https://github.com/polleverywhere/anybase/compare/v0.1.0...HEAD)

## 0.1.0 (2022-09-30)

There's a bunch of changes, including some breaking ones in this commit. Starting with this
release, this gem is owned and maintained by Poll Everywhere.

[0.1.0 commits](https://github.com/polleverywhere/anybase/compare/v0.0.15...v0.1.0)

### Added

- This Changelog.
- A Code of Conduct for community contributions.
- Rubocop and the Poll Everywhere style rules.
- New gemspec metadata fields — especially the MFA requirement to submit to RubyGems.
- Modern gem defaults like "bin/consle".
- Instead of just an empty `RuntimeError`, the following errors no return to give more
  information about what the error is:
  + `NegativeSignListedAsDigitError`
  + `NegativeSignTooLongError`
  + `UnknownNegativeSignError`

### Changed

- Ownership to Poll Everywhere (per the conversation with the previous owner](https://github.com/joshbuddy/anybase/issues/6)).
- Switch to using named parameters instead of an "opts" hash. (This means you can't pass
  options using hash rockets anymore. For example `Anybase("abc", :ignore_case => true)` will
  no longer work. Use `Anybase("abc", ignore_case: true)` instead.)
- The `Anybase#random` parameter named "zero_pad" was renamed to "trim_leading_zeros", and
  this new parameter should be passed the opposite of value of the former. (So if you called
  `random(4, zero_pad: false)` before, now call `random(4, trim_leading_zeros: true)`.)
- When intializing an `Anybase` object, the "sign" option was renamed to "negative_sign".
- Calling `Anybase#normalize` now always returns a new string.
- Use GitHub Actions instead of Travis to run CI tests.
- Updated RSpec.


### Fixed

- Passing `ignore_case: true` modified the digits string passed in at object creation. The
  code now makes a copy for its use so that user input isn't unexpectedly modified.

### Deprecated

- Support for Ruby series that are [no longer maintained](https://www.ruby-lang.org/en/downloads/branches/).
  (At the time of publication, that was any series older than Ruby 2.7.)

### Removed

- Support for Ruby 1.9.3. You must use Ruby 2.0 or higher.


## Previous versions

Older versions didn't keep a changelog, but here is a list along with a link to the commits
for each version:

- [0.0.15 (2016-02-11)](https://github.com/polleverywhere/anybase/compare/v0.0.14...v0.0.15)
- [0.0.14 (2011-12-20)](https://github.com/polleverywhere/anybase/compare/v0.0.13...v0.0.14)
- [0.0.13 (2011-12-20)](https://github.com/polleverywhere/anybase/compare/v0.0.12...v0.0.13)
- [0.0.12 (2011-11-18)](https://github.com/polleverywhere/anybase/compare/v0.0.11...v0.0.12)
- [0.0.11 (2010-08-07)](https://github.com/polleverywhere/anybase/compare/v0.0.10...v0.0.11)
- [0.0.10 (2010-07-26)](https://github.com/polleverywhere/anybase/compare/v0.0.9...v0.0.10)
- [0.0.9 (2010-05-17)](https://github.com/polleverywhere/anybase/compare/v0.0.8...v0.0.9)
- [0.0.8 (2010-03-15)](https://github.com/polleverywhere/anybase/compare/v0.0.7...v0.0.8)
- [0.0.7 (2010-03-01)](https://github.com/polleverywhere/anybase/compare/v0.0.6...v0.0.7)
- [0.0.6 (2010-02-02)](https://github.com/polleverywhere/anybase/compare/v0.0.5...v0.0.6)
- [0.0.5 (2010-01-24)](https://github.com/polleverywhere/anybase/compare/v0.0.4...v0.0.5)
- [0.0.4 (2010-01-24)](https://github.com/polleverywhere/anybase/compare/v0.0.3...v0.0.4)
- [0.0.3 (2009-12-10)](https://github.com/polleverywhere/anybase/compare/v0.0.2...v0.0.3)
- [0.0.2 (2009-12-03)](https://github.com/polleverywhere/anybase/compare/v0.0.1...v0.0.2)
- [0.0.1 (2009-11-21)](https://github.com/polleverywhere/anybase/releases/tag/v0.0.1)
