require 'spec_helper'

describe BookmarkObserver do
  describe "after_create" do
    it "should shorten the url" do
      RestClient.should_receive(:post).with("http://api.bit.ly/shorten", {:apiKey=>"R_5e272f76feea07267115ba4f07d95f58", 
                                             :version=>"2.0.1", 
                                             :login=>"alankennedy100", 
                                             :longUrl=>"http://www.bbc.co.uk"}).and_return(
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
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk")
      bookmark.short_url.should match(/bit.ly/)
    end
  end
end