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

### Configure

To start with, we kept it pretty simple, install this gem & then configure your
API Token and email using the following interface, This will store your Ribose
configuration as `.riboserc` in the home directory.

```sh
ribose config --token="YOUR_API_TOKEN" --email="youremail@example.com"
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

#### Show a space details

```sh
ribose space show --space-id 123456789
```

#### Create a new space

To create a new user space we can use the following interface

```sh
ribose space add --name "Space name" --access "open" --category-id 12 \
  --description "Space description"
```

#### Update a space

```sh
ribose space update --space-id 123456 --name "New Space Name"
```

#### Remove an existing space

```sh
ribose space remove --space-id 123456789 --confirmation 123456789
```

### Note

#### Listing space notes

```sh
ribose note list --space-id space_uuid --format json
```

#### Create a new note

```sh
ribose note add --space-id space_uuid --title "Name of the note"
```

#### Remove a note

```sh
ribose note remove --space-id space_uuid --note-id note_uuid
```

### Files

#### Listing files

Ribose space may contain multiple files, and if we want to retrieve the list of
the files of any space then we can use to following interface.

```sh
ribose file list --space-id 123456
```

The above interface will retrieve the basic details in tabular format, but it
also support additional `format` option, acceptable option: `json`.

#### Add a new file

Ribose CLI allows us to upload a file in a user space, and to upload a new file
we can use the following interface.

```sh
ribose file add full_path_the_file.ext  --space-id space_uuid **other_options
```

### Conversations

#### Listing conversations

```sh
ribose conversation list --space-id 123456789
```

#### Show a conversation details

```sh
ribose conversation show --space-id 123456789 --conversation-id 67890
```

#### Create A New Conversation

```sh
ribose conversation add --space-id 123456789 --title "Conversation Title" \
  --tags "sample, conversation"
```

#### Update a conversation

```sh
conversation update --conversation-id 5678 --space-id 123456789 --title \
"Conversation Title" --tags "sample, conversation"
```

#### Remove A Conversation

```sh
ribose conversation remove --space-id 1234 --conversation-id 5678
```

### Message

#### Listing conversation messages

```sh
ribose message list --space-id 12345 --conversation-id 56789
```

#### Add a new message to conversation

```sh
ribose message add --space-id 12345 --conversation-id 56789 \
  --message-body "Welcome to Ribose Space"
```

#### Edit an existing message


```sh
ribose message add --message-id 123456 --space-id 12345 \
  --conversation-id 56789 --message-body "Welcome to Ribose Space"
```

#### Remove an existing message

```sh
ribose message remove --message-id 1234 --space-id 12345 --conversation-id 456
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
