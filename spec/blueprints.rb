require 'faker'

Sham.url {Faker::Internet.domain_name}

Bookmark.blueprint do
  url
end