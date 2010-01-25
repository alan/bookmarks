require 'spec_helper'

describe BookmarkObserver do
  describe "after_create" do
    before(:each) do
      RestClient.should_receive(:post).with("http://api.bit.ly/shorten", {:apiKey => "R_5e272f76feea07267115ba4f07d95f58", 
                                             :version => "2.0.1", 
                                             :login => "alankennedy100", 
                                             :longUrl => "http://www.bbc.co.uk"}).and_return(
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
    end
    
    it "should shorten the url" do
      stub_request(:get, "http://www.bbc.co.uk/").to_return(:headers => {"expires"=>"Mon, 25 Jan 2010 23:03:09 GMT", 
                                                                        "connection"=>"Keep-Alive", 
                                                                        "content-type"=>"text/html",
                                                                        "Content-Length" => "111336",
                                                                        "date"=>"Mon, 25 Jan 2010 23:03:09 GMT", 
                                                                        "server"=>"Apache", "content-length"=>"110537", 
                                                                        "set-cookie"=>"BBC-UID=d43b450e82; expires=Fri, 24-Jan-14 23:03:09 GMT; path=/; domain=bbc.co.uk;", 
                                                                        "accept-ranges"=>"bytes", 
                                                                        "cache-control"=>"max-age=0", 
                                                                        "keep-alive"=>"timeout=4, max=200", 
                                                                        "pragma"=>"no-cache"},
                                                            :body => File.open(File.dirname(__FILE__) + '/../stubs/test_page.html'))
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk")
      bookmark.short_url.should match(/bit.ly/)
    end
    
    it "should fetch meta information about the url" do
      stub_request(:get, "http://www.bbc.co.uk/").to_return(:headers => {"expires"=>"Mon, 25 Jan 2010 23:03:09 GMT", 
                                                                        "connection"=>"Keep-Alive", 
                                                                        "content-type"=>"text/html",
                                                                        "Content-Length" => "111336",
                                                                        "date"=>"Mon, 25 Jan 2010 23:03:09 GMT", 
                                                                        "server"=>"Apache", "content-length"=>"110537", 
                                                                        "set-cookie"=>"BBC-UID=d43b450e82; expires=Fri, 24-Jan-14 23:03:09 GMT; path=/; domain=bbc.co.uk;", 
                                                                        "accept-ranges"=>"bytes", 
                                                                        "cache-control"=>"max-age=0", 
                                                                        "keep-alive"=>"timeout=4, max=200", 
                                                                        "pragma"=>"no-cache"},
                                                            :body => File.open(File.dirname(__FILE__) + '/../stubs/test_page.html'))
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk")
      bookmark.page_title.should == "BBC - Homepage"
      bookmark.page_description.should == "Breaking news, sport, TV, radio and a whole lot more. The BBC informs, educates and entertains - wherever you are, whatever your age."
    end
    
    it "should not attempt to fetch page title or page descriptionif given" do
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk", :page_title => "BBC Page", 
                                  :page_description => "The BBC page")
      bookmark.page_title.should == "BBC Page"
      bookmark.page_description.should == "The BBC page"
    end
  end
end