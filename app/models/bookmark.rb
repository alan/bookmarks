class Bookmark < ActiveRecord::Base
  include Searchable
  
  belongs_to :site
  
  validates_presence_of :url
  
  def validate_on_create
    errors.add(:url, "does not look like a URL") unless host
  end
  
  before_create :assign_site
  
  named_scope :by_newest, :order => "created_at DESC"
  named_scope :limit, lambda{ | limit |
    {
      :limit => limit
    }
  }
  
  def assign_site
    self.site = Site.find_or_create_by_name(host)
  end
  
  # def self.search(query)
  #   like = "%#{query}%"
  #   all(:conditions => ["url LIKE ? OR tags LIKE ?", like, like])
  # end
  
  private
  
  def host
    URI.parse(url).host
  end
end
