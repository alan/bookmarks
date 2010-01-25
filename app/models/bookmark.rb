class Bookmark < ActiveRecord::Base
  belongs_to :site
  
  is_taggable :tags
  
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
  
  private
  
  def host
    URI.parse(url).host
  end
end
