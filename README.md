# NBA.rb

[![Gem Version](https://badge.fury.io/rb/nba.png)][gem]
[![Build Status](https://secure.travis-ci.org/larrylv/nba.png?branch=master)][travis]

[gem]: https://rubygems.org/gems/nba
[travis]: https://travis-ci.org/larrylv/nba

NBA.rb is a Ruby library for retrieving NBA League games, schedules, teams and players.

Insipred by [@sferik][sferik]'s [MLB.rb][mlb].

[sferik]: https://github.com/sferik
[mlb]: https://github.com/sferik/mlb

## Installation
    gem install nba

## Usage Examples
    $ irb
    >> require 'nba'
    >> NBA::Game.all '20140102'
    #  =>  Final/OT  -   Cavaliers     87  :  81    Magic
    #  =>    Final   -      Heat      114  : 123   Warriors
    #  =>    Final   -     Bulls       94  :  82   Celtics
    #  =>    Final   -    Thunder      93  :  95     Nets
    #  =>    Final   -     Spurs      101  : 105    Knicks
    #  =>    Final   -      Suns       91  :  99  Grizzlies
    #  =>    Final   -      Jazz       96  :  87    Bucks
    #  =>    Final   - Trail Blazers  134  : 104   Bobcats
    #  =>    Final   -     Kings      104  : 113    76ers
    >> NBA::Team.all.first.name                    # => "Atlanta Hawks"
    >> NBA::Team.all.first.founded                 # => 1946
    >> NBA::Team.all.first.players.first.name      # => "Al Horford"
    >> NBA::Team.all.first.players.first.number    # => 15
    >> NBA::Team.all.first.players.first.position  # => ["Forward-center"]

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* Ruby 2.1.0
* [Rubinius][]
* [JRuby][]

[rubinius]: http://rubini.us/
[jruby]: http://jruby.org/

If something doesn't work on one of these interpreters, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.

## Colophon
NBA was built with the following tools:

* [Bundler][]
* [Freebase][]
* [Faraday][]
* [Markdown][]
* [RSpec][]
* [vim][]
* [WebMock][]

[bundler]: http://gembundler.com/
[freebase]: http://www.freebase.com/
[faraday]: https://github.com/technoweenie/faraday
[markdown]: http://daringfireball.net/projects/markdown/
[rspec]: http://relishapp.com/rspec/
[vim]: http://www.vim.org/
[webmock]: https://github.com/bblimke/webmock

And, special thanks to [@sfeirk][sferik]!

## Contributing

1. Fork it ( http://github.com/larrylv/nba/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright (c) 2010-2014 Larry Lv. See [LICENSE][] for details.

[license]: LICENSE.md

