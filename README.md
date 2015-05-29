# Glipper

**pending**

## Installation

Add this line to your application's Gemfile:

    gem 'glipper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glipper

## Usage

**pending**

```ruby
module GliperHelper

  protected def glip(resource)
    ApplicationDrapper.decorate(resource, self)
  end

end
```

Files `app/drappers/*_drapper.rb`.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/glipper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
