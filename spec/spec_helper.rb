# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'

require 'machinist/active_record'
require 'sham'
require 'webmock/rspec'

include WebMock

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  
  config.before(:all) { Sham.reset(:before_all) }
  
  config.before(:each)   { 
    Sham.reset(:before_each) 
    RestClient.stub!(:post).and_return(
    <<-RESPONSE
      {\n \"errorCode\": 0, 
        \n \"errorMessage\": \"\", 
        \n \"results\": {\n \"http://www.bbc.co.uk\": {\n 
                                        \"hash\": \"wAJUK\", 
                                        \n \"shortCNAMEUrl\": \"http://bit.ly/5A206o\", 
                                        \n \"shortKeywordUrl\": \"\", 
                                        \n \"shortUrl\": \"http://bit.ly/5A206o\", 
                                        \n \"userHash\": \"5A206o\"\n }\n }, 
        \n \"statusCode\": \"OK\"\n}
    RESPONSE
    )
  }
end
