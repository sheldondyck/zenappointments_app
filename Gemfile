source 'https://rubygems.org'

# TODO extract to seperate module
def is_mac?
  RUBY_PLATFORM.downcase.include?('darwin')
end

def is_linux?
  RUBY_PLATFORM.downcase.include?('linux')
end

ruby '2.0.0'

gem 'rails', '4.0.1'

# TODO had to downgrade multi_json and sass because rails refused to init.
# Remove this line and try again later
gem 'sass', '3.2.11'

#gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'sass-rails' #'~> 4.0.1', :git => 'git://github.com/rails/sass-rails.git'
gem 'coffee-rails' #, '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder' #, '~> 1.2'
#gem 'turbolinks'
gem 'uglifier' #, '>= 1.3.0'
gem 'bcrypt-ruby' #, '~> 3.0.0'
gem 'haml'
#gem 'rdiscount' # used for :markdown in haml
gem 'pg'
gem 'foreigner'
#gem 'bootstrap-sass' #, '~> 2.3.2.0'
gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
gem 'font-awesome-rails'
#gem 'chart-js-rails'
#gem 'angularjs-rails'
gem 'awesome_print'

group :development do
  gem 'therubyracer', platforms: :ruby
  gem 'rspec-rails'
  gem 'brakeman', :require => false
  gem 'rails_best_practices'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'annotate' #, :git => 'git://github.com/ctran/annotate_models.git'
  # To use debugger
  #gem 'ruby-debug'
  gem 'debugger'
  # gem 'ruby-debug19', :require => 'ruby-debug'

  #gem 'rb-inotify' if is_linux?
  #gem 'rb-fsevent' if is_mac?
end

group :test do
  gem 'turn', '>= 0.8.3', :require => false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard', '>=2.1.0'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-zeus'
  gem 'libnotify'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'awesome_print'
  gem 'debugger'
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

