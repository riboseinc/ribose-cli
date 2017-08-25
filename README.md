# Ribose CLI

[![Build
Status](https://travis-ci.org/riboseinc/ribose-cli.svg?branch=master)](https://travis-ci.org/riboseinc/ribose-cli)
[![Code
Climate](https://codeclimate.com/github/riboseinc/ribose-cli/badges/gpa.svg)](https://codeclimate.com/github/riboseinc/ribose-cli)

The command line interface to the Ribose API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ribose-cli"
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install ribose-cli
```

## Usage

To start with, we kept it pretty simple, clone this repo and then configure the
following environment variables to get everything working.

```sh
export RIBOSE_API_TOKEN=YOUR_SECRET_API_TOKEN
export RIBOSE_USER_EMAIL=YOUR_EMAIL_FOR_RIBOSE
```

### Spaces

The `space` command retrieve space related resources, please use the `help`
command to see what's sub-commands are available.

```sh
ribose help space
```

#### Listing spaces

To list out the spaces, please use the `list` command, by default it will print
out the basic information in tabular format.

```sh
ribose space list
```

This interface also has support `json` format, if we want the output to be in
`json` then we can use the following

```sh
ribose space list --format json
```

## Development

We are following Sandi Metz's Rules for this gem, you can read the
[description of the rules here][sandi-metz] All new code should follow these
rules. If you make changes in a pre-existing file that violates these rules you
should fix the violations as part of your contribution.

### Setup

Clone the repository.

```sh
git clone https://github.com/riboseinc/ribose-cli
```

Setup your environment.

```sh
bin/setup
```

Run the test suite

```sh
bin/rspec
```

## Contributing

First, thank you for contributing! We love pull requests from everyone. By
participating in this project, you hereby grant [Ribose Inc.][riboseinc] the
right to grant or transfer an unlimited number of non exclusive licenses or
sub-licenses to third parties, under the copyright covering the contribution
to use the contribution by all means.

Here are a few technical guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests to support your new feature.
1. Make sure the entire test suite passes locally and on CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

## Credits

This gem is developed, maintained and funded by [Ribose Inc.][riboseinc]

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[riboseinc]: https://www.ribose.com
[issues]: https://github.com/riboseinc/ribose-cli/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature
[sandi-metz]: http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers
