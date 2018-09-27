# PostmarkMailer

This gem is designed to provide a (nearly) drop-in replacement for Ruby on Rails' `ActionMailer` for those wishing to deliver emails using [Postmark's Templates API](https://postmarkapp.com/why/templates). Its interface mimics that of `ActionMailer` so switching existing mailers should require minimal effort, and usage should be familiar to most Ruby on Rails developers.

_**NOTE:** This gem only provides a means of delivering transactional emails from a Ruby on Rails application with a Postmark template, and does **not** provide any functionality for managing templates. Such functionality is already provided by Postmark's API and their Ruby client._

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postmark_mailer', github: 'scienceexchange/postmark_mailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postmark_mailer

## Usage

To start sending emails with Postmark's templates, you will need to set up some minimal configuration, and then make some changes to the mailer classes themselves.

### Configuration

In `app/initializers/postmark_mailer.rb`, add the following configuration block:

```ruby
PostmarkMailer.configure do |config|
  config.api_key = YOUR_POSTMARK_API_KEY # required
  config.default_delivery_queue = :mailers # defaults to :default
end
```

### Defining Mailers

To illustrate the usage of `PostmarkMailer`, let's take a look at a typical Rails mailer:

```ruby
class MyCoolMailer < ActionMailer::Base
  def welcome(user)
    @user = user

    mail(
      to: @user.email,
      subject: 'Welcome to Our Product!'
    )
  end
end
```

The same mailer, using this gem would look like this:

```ruby
class MyCoolMailer < PostmarkMailer::Base
  def welcome(user)
    mail(
      to: user.email,
      template_id: 123_456,
      template_model: {
        first_name: user.first_name
      }
    )
  end
end
```

Note the important changes:

* The mailer now inherits from `PostmarkMailer::Base` instead of `ActionMailer::Base`.
* You add `template_id` to your options hash. _(This is required.)_
* You add `template_model` to your options hash, which is an optional hash of whatever data you'd like to render in your template. _(This is optional–in the unlikely event your template does not render any specific data, you can safely omit this option.)_

The options you pass into the `#mail` method are ultimately passed on to the `#deliver_with_template` method provided by the Postmark API Ruby client, and so you'll want to [refer to their documentation for a list of all the availabale options](https://postmarkapp.com/developer/api/templates-api#email-with-template).

Because Postmark handles the templating and rendering, you no longer need the views for this mailer, so in this example, you could safely remove `app/views/mailers/my_cool_mailer/welcome.html.erb`.

### Delivering Mailers

Just as you would with a standard mailer, simply call:

```ruby
MyCoolMailer.welcome(user).deliver_later
```

or, less optimally:

```ruby
MyCoolMailer.welcome(user).deliver_now
```

### Preventing Delivery

In some mailers, you may wish to prevent delivery based on some business logic. For instance, if you offer email preferences to your users, you may want to check their preferences and prevent delivery if they've disabled email notifications.

To add mailer-wide logic, simply define a `prevent_delivery?` method in your mailer:

```ruby
class MyCoolMailer < PostmarkMailer::Base
  def welcome(user)
    @user = user
    mail(
      to: @user.email,
      template_id: 123_456,
      template_model: {
        first_name: @user.first_name
      }
    )
  end

  private

  def prevent_delivery?
    # Substitute the line below with your own logic
    @user.all_emails_disabled?
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

This gem is in it's infancy, so functionality is extremely limited at this point. Bug reports and pull requests are welcome on GitHub at https://github.com/scienceexchange/postmark_mailer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## About Science Exchange

PostmarkMailer is maintained by [Science Exchange](https://www.scienceexchange.com), the leading platform for outsourcing scientific research and development. Science Exchange is not affiliated with Postmark or Wildbit, LLC, and usage of Postmark is subject to their Terms of Service.

If you're interested helping improve the pace of scientific research, you should know that [we're hiring!](https://jobs.lever.co/scienceexchange/e277508e-1bda-4ed2-b3f3-ed78d3345402)
