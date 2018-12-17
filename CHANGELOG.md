## [Unreleased]
### Changed
* `delete_link` now adds a `data-confirm` attribute by default (#25)
* `{details,edit,delete}_link` integrate with authorisation, if possible (#26)

### Added
* Added `bootstrap_icon_spinner` helper methods
* Add `inline_controls_for` button toolbar helper (#27)
* Added the Rails generated HTML id to readonly form input equivalents (#29)

## 1.12.2 / 2018-06-22
### Fixed
* Address issue with datepicker SCSS (#22)

## 1.12.1 / 2018-05-01
### Fixed
* Correct issue with inline errors

## 1.12.0 / 2018-04-27
### Added
* Add support for Rails 5.1 / 5.2
* Added `bootstrap_modal_{dialog,header,body,footer}_tag` helper methods
* Added readonly ``bootstrap_modal_box`` button option

### Fixed
* `inline_errors` shouldn't break with basic objects
* Add fix for inline errors issue
* try to fix some I18n issues
* fix tooltips tests that had previously been spuriously passing
* Ensure `assert_select` is being used correctly. Resolves #18.
* fix SASS precompilation when using datepicker
* labels should not contain the 'for' HTML attribute when readonly (#16)
* Fix to the label `tooltip: false`. Resolves #15
