disable_system_gems

gem "rails", "2.3.5"
gem "haml"
gem "mysql"
gem "rest-client", :require_as => 'restclient'
gem 'yajl-ruby', :require_as => 'yajl'

only "test" do
  gem "rspec"
  gem "rspec-rails"
  gem "machinist"
  gem "faker"
end

only "cucumber" do
  gem "cucumber"
  gem "cucumber-rails"
  gem "webrat"
  gem "database_cleaner"
end

bundle_path "vendor/bundler_gems"