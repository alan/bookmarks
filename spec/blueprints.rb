require 'faker'

Sham.url {"http://" + Faker::Internet.domain_name}

Bookmark.blueprint do
  url
  page_title {"The page title"}
  page_description {"The page description" }
end