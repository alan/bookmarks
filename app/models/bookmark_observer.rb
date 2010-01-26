class BookmarkObserver < ActiveRecord::Observer
  def after_create(bookmark)
    shorten_url(bookmark)
    fetch_metadata(bookmark)
  end
  
  private
  
  def fetch_metadata(bookmark)
    # refactor
    mechanize = WWW::Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }
    
    page = nil
    unless bookmark.page_title
      page = mechanize.get(bookmark.url)
      bookmark.page_title = page.title
    end
    unless bookmark.page_description
      page ||= mechanize.get(bookmark.url)
      begin
        page_description = page.parser.search('//meta[@name="description"]').attribute("content").value
      rescue => e
        page_description = "No description found"
      end
      bookmark.page_description = page_description if page_description
    end
    bookmark.save
  end
  
  def shorten_url(bookmark)
    response = RestClient.post('http://api.bit.ly/shorten', api_signature.merge(:longUrl => bookmark.url))
    short_url = get_short_url(response)
    bookmark.update_attribute(:short_url, short_url)
  end
  
  def api_signature
    {:version => Bitly::Config[:version], :apiKey => Bitly::Config[:apiKey], :login => Bitly::Config[:login]}
  end
  
  # need to do this for the stubbing of RestClient in the specs
  def get_short_url(response)
    results = Yajl::Parser.parse(response)['results']
    url = results.keys.first
    results[url]['shortUrl']
  end
end