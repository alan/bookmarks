Given /^the following bookmarks:$/ do |bookmarks|
  bookmarks.hashes.each do |bookmark|
    Bookmark.create!(bookmark)
  end
end
