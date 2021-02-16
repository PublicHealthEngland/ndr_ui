# NdrUi [![Build Status](https://github.com/publichealthengland/ndr_ui/workflows/Test/badge.svg)](https://github.com/publichealthengland/ndr_ui/actions?query=workflow%3Atest) [![Gem Version](https://badge.fury.io/rb/ndr_ui.svg)](https://rubygems.org/gems/ndr_ui) [![Documentation](https://img.shields.io/badge/ndr_ui-docs-blue.svg)](https://www.rubydoc.info/gems/ndr_ui)

This is the Public Health England (PHE) National Disease Registration (NDR) User Interface rubygem,
providing a set of core features:

1. jQuery
2. [Bootstrap](http://getbootstrap.com)
3. a Bootstrap based Rails Form Builder
4. ~~Bootstrap based pagination links~~
5. Bootstrap based Rails Helpers

and a set of opt-in plugins:

1. Bootstrap based [datepicker](https://github.com/eternicode/bootstrap-datepicker)
2. [Timeago](https://github.com/rmm5t/jquery-timeago) jQuery plugin and Rails Helper

Adding third-party plugins to the gem allows us to fix our systems to clearly defined
versions of the third-party libraries and enables us to add syntactic sugar (in the form of
preferred setup/defaults and rails helper methods, for example).

To experiment with the code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ndr_ui'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ndr_ui

## Usage

Require NdrUi javascripts at the top of `app/assets/javascripts/application.js`:

```javascript
//= require ndr_ui
```

Import NdrUi styles at the top of `app/assets/stylesheets/application.scss`:

```scss
/*
*= require ndr_ui
*/
```

Require NdrUi::BootstrapHelper near the top of `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  ...

  helper NdrUi::BootstrapHelper
end
```

### Datepicker

To use the Bootstrap based [datepicker](https://github.com/eternicode/bootstrap-datepicker), require it after ndr_ui. For example:

In `app/assets/javascripts/application.js`:

```javascript
//= require ndr_ui
//= require ndr_ui/datepicker
```

In `app/assets/stylesheets/application.scss`:

```scss
/*
*= require ndr_ui
*= require ndr_ui/datepicker
*/
```

Use `<%= form.datepicker_field(method, options) %>` in your Bootstrap forms (see the method documentation for more details).

### Timeago

To use the [Timeago](https://github.com/rmm5t/jquery-timeago) jQuery plugin and helper method:

Require it after ndr_ui at the top of `app/assets/javascripts/application.js`:

```javascript
//= require ndr_ui
//= require ndr_ui/timeago
```

Require NdrUi::TimeagoHelper near the top of `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  ...

  helper NdrUi::BootstrapHelper
  helper NdrUi::TimeagoHelper
end
```

Use `<%= timeago_tag(some_time) %>` in your views (see the helper method documentation for more details).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PublicHealthEngland/ndr_ui.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

