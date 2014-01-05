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
You could use `nba` command-line tool directly in your terminal.

  	$ nba games --date=20140102
    Final/OT  -   Cavaliers     87  :  81    Magic
      Final   -      Heat      114  : 123   Warriors
      Final   -     Bulls       94  :  82   Celtics
      Final   -    Thunder      93  :  95     Nets
      Final   -     Spurs      101  : 105    Knicks
      Final   -      Suns       91  :  99  Grizzlies
      Final   -      Jazz       96  :  87    Bucks
      Final   - Trail Blazers  134  : 104   Bobcats
      Final   -     Kings      104  : 113    76ers
  	$ nba teams --name 'Lakers'
    Name: Los Angeles Lakers
    Founded: 1947
    Conference: Western Conference
    Division: Pacific Division
    Coach: Mike D'Antoni
    Championships: 2010 NBA Finals, 2009 NBA Finals
                   2002 NBA Finals, 2001 NBA Finals
                   2000 NBA Finals, 1988 NBA Finals
               	   1987 NBA Finals, 1985 NBA Finals
               	   1982 NBA Finals, 1980 NBA Finals
               	   1972 NBA Finals, 1954 NBA Finals
               	   1953 NBA Finals, 1952 NBA Finals
               	   1950 NBA Finals, 1949 BAA Finals
               	   1948 NBL Finals

Or you could use it in `irb`, which is an Interactive Ruby Shell

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

* Ruby 1.9.3
* Ruby 2.0.0
* Ruby 2.1.0
* [JRuby][]

[jruby]: http://jruby.org/

## Colophon
NBA was built with the following tools:

* [Bundler][]
* [Freebase][]
* [Faraday][]
* [Markdown][]
* [RSpec][]
* [vim][]
* [WebMock][]
* [Thor][]

[bundler]: http://gembundler.com/
[freebase]: http://www.freebase.com/
[faraday]: https://github.com/technoweenie/faraday
[markdown]: http://daringfireball.net/projects/markdown/
[rspec]: http://relishapp.com/rspec/
[vim]: http://www.vim.org/
[webmock]: https://github.com/bblimke/webmock
[thor]: https://github.com/erikhuda/thor

And, special thanks to [@sfeirk][sferik]!

## Contributing

1. [Fork it](http://github.com/larrylv/nba/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright (c) 2010-2014 Larry Lv. See [LICENSE][] for details.

[license]: LICENSE.md

