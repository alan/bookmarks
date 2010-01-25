require 'faker'

Sham.url {"http://" + Faker::Internet.domain_name}

Bookmark.blueprint do
  url
end