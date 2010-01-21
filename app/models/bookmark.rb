class Bookmark < ActiveRecord::Base
  
  named_scope :by_newest, :order => "created_at DESC"
  named_scope :limit, lambda{ | limit |
    {
      :limit => limit
    }
  }
end
