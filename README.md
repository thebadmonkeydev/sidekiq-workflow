# Sidekiq::Workflow
_sidekiq-workflow is currently in development and is not yet suited to
production use.  Please continue at your own risk...you have been warned
and will be PUNISHED!_

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-workflow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-workflow

## Usage

To run a workflow, sidekiq-workflow provides a simple interface:

```
Sidekiq::Workflow.run(sequence_definition)
```

A sequence definition is composed of an array-defined workflow.  The
convention here is that jobs within the root array element are executed
sequentially, one level deeper is executed in parallel.  Currently,
sidekiq-workflow only supports simple embedded parallelism at one level.
This means that it only supports workflows like the following:

```
         worker_2
        /        \
worker_1          worker_4
        \        /
         worker_3
```
A workflow like this is easily defined with the following structure:
```ruby
[
  worker_1,
  [worker_2, worker_3],
  worker_4
]
```
workers in the root array are processed sequentially and any workers in nested
arrays are processes in parrallel.  The `worker_#` values above can be a
strings or worker class names so:

```ruby
[
  "AccountWorker",
  ["UserWorker", "ProfileWorker"],
  "EmailWorker"
]
```

is equivalent to

```ruby
[
  AccountWorker,
  [UserWorker, ProfileWorker],
  EmailWorker
]
```

## Coming Soon

Parameter passing and custom worker methods will be coming shortly as
well as expanded workflow structure providing for any mixture of
sequential and parallel definitions to make workflows like this
possible:

```
                  worker_5
                 /        \
         worker_4          ----worker_7
        /        \        /   /
worker_1          worker_6   /
        \                   /
         worker_2---worker_3

```

## Development

sidekiq-workflow is being developed in tandom with a series of tutorials on the process of [developing a rails gem](https://badmonkeydev.wordpress.com/2015/06/04/how-to-build-your-own-ruby-gem-from-start-to-finish/).  Feel free to follow along or to use the series as a means of coming up to speed on the code.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaelkelly322/sidekiq-workflow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Please also take a look at [this post](https://badmonkeydev.wordpress.com/2015/05/23/code-review-best-practices/) for guidlines on submitting pull requests.  Thanks!


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

