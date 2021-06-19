# Dupler

Easy-to-use template engine driver.

## Overview

Dupler provides you a simple command line interface to document generation environment using template engine especially in ERB format.

Typical use cases are:

 - generate configuration files for some different environments
 - generate test data

Technically dupler is just a cli wrapper of `Tilt` template engine.
And Dupler supports ActiveSupport by default in template.

## Installation

Install it by using just below command:

    $ gem install dupler

## Usage

You can generate your project bootstrap with `dupler new` command.

    $ dupler new myproject

Then you will find new `myproject` project is generated on your current directory.

Inside the directory, below files are there.

 - values.yaml : You can define any values for placeholder in the templates
 - templates : In this directory, all files will be processed by dupler as template file.

You can just execute `dupler` command on top of your project folder, then output file will be generated in `output` directory.

    $ dupler

Or you can specify like below

    $ dupler -c values.yaml output templates/*

## Examples

How to write template and values.yaml? Here is the example of Dupler config file (values.yaml) and template in ERB format.

### values.yaml

First you should define your valiables in values.yaml file. (Filename is configurable in `dupler` command in `-c` option.)

```
sample:
  name: Dupler
  records: 5
```

### templates/sample.md.erb

Then you can write template with above values. In dupler, values.yaml is load as Hashie::Mash, it means you can access all of the elements with dot notation like `sample.name`.

```
# Dupler Example

This file is generated by <%= sample.name %> <%= Dupler::VERSION %>.
Generated at: <%= Time.now %>

## List sample

Iteration example with ActiveSupport time expression.

<% sample.records.times do |i| %>
 - <%= i %>, <%= i.days.after.iso8601 %>
<% end %>
```

### Outcome file

You can build document using below command:

    $ dupler

Or you can specify like below:

    $ dupler -c values.yaml output templates/sample.md.erb

Output document will be like this:

```
# Dupler Example

This file is generated by Dupler 0.1.0.
Generated at: 2021-06-19 23:14:28 +0900

## List sample

Iteration example with ActiveSupport time expression.

 - 0, 2021-06-19T23:14:28+09:00
 - 1, 2021-06-20T23:14:28+09:00
 - 2, 2021-06-21T23:14:28+09:00
 - 3, 2021-06-22T23:14:28+09:00
 - 4, 2021-06-23T23:14:28+09:00
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/daixque/dupler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/daixque/dupler/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dupler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/daixque/dupler/blob/master/CODE_OF_CONDUCT.md).
