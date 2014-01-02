source 'https://rubygems.org'

gem 'rake'

group :development do
  gem 'pry'
  gem 'pry-rescue'
  platforms :ruby_19, :ruby_20 do
    gem 'pry-debugger'
    gem 'pry-stack_explorer'
  end
end

group :test do
  gem 'rspec', '>= 2.11'
  gem 'webmock'
end

gem 'jruby-openssl', :platforms => :jruby
gem 'rubysl', '~> 2.0', :platform => :rbx

# Specify your gem's dependencies in nba.gemspec
gemspec
