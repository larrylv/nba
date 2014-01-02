# NBA.rb

[![Gem Version](https://badge.fury.io/rb/nba.png)][gem]
[![Build Status](https://secure.travis-ci.org/larrylv/nba.png?branch=master)][travis]

[gem]: https://rubygems.org/gems/nba
[travis]: https://travis-ci.org/larrylv/nba

NBA.rb is a Ruby library for retrieving NBA League players, teams and divisions.

Insipred by [@sferik][sferik]'s [MLB.rb][mlb].

[sferik]: https://github.com/sferik
[mlb]: https://github.com/sferik/mlb

## Installation
    gem install nba

## Usage Examples
    $ irb
    >> require 'nba'
    >> NBA::Team.all.first.name                    # => "Atlanta Hawks"
    >> NBA::Team.all.first.division                # => "Southeast Division"
    >> NBA::Team.all.first.founded                 # => 1946
    >> NBA::Team.all.first.players.first.name      # => "Al Horford"
    >> NBA::Team.all.first.players.first.number    # => 15
    >> NBA::Team.all.first.players.first.position  # => ["Forward-center"]

## Contributing

1. Fork it ( http://github.com/larrylv/nba/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright (c) 2010-2014 Larry Lv. See [LICENSE][] for details.

[license]: LICENSE.md

