# Gigbot

Git-inspired remote tech job aggregator for the command line.

**Gigbot is in active development for personal use. There will be bugs!**

When seeking a new remote software engineering gig, there are numerous job
boards all over the web. Wouldn't it be nice to be able to pull listings
from all of them and see them aggregated in one place?

Gigbot is a command line tool that scrapes job listings from various job
boards across the web and allows browsing them from the command line to
help you find your next gig!

For personal use only.

## Installation

I have yet to push a release to RubyGems, so for now you'll need to
install it manually:

``` 
git clone https://github.com/teejayvanslyke/gigbot.git
cd gigbot
gem install gigbot.gemspec
```

## Usage

### Commands

#### `gigbot update`

Fetches new jobs from all sources.

#### `gigbot list`

Lists all jobs, newest first.

#### `gigbot show <sha>`

Shows the full job listing for the job sha specificed.

#### `gigbot deep`

Deep-updates all existing jobs. This command fetches each individual job
page and extracts the full description of the job for those job boards
that lack RSS feeds.

#### `gigbot clean`

Purges all job data.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/teejayvanslyke/gigbot.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
