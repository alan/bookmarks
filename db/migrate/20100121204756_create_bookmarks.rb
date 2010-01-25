class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.text :url, :null => false
      t.string :short_url
      t.text :tags
      t.string :page_title
      t.text :page_description
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
