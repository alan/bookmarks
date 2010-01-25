class BookmarkObserver < ActiveRecord::Observer
  def after_create(bookmark)
    bitly_login = 'alankennedy100'
    bitly_key = 'R_5e272f76feea07267115ba4f07d95f58'
    response = RestClient.post('http://api.bit.ly/shorten', api_signature.merge(:longUrl => bookmark.url))
    short_url = get_short_url(response)
    bookmark.update_attribute(:short_url, short_url)
  end
  
  private
  
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