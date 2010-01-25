Feature: Search bookmarks
  In order to save time
  As a user
  I want to search bookmarks

Background:
	Given the following bookmarks:
		| url                      | tags        |
		| http://www.bbc.co.uk     | tv, news    |
		| http://www.itv.co.uk     | tv, news    |
		| http://www.ruby-lang.org | programming |

Scenario: Searching a bookmark by the url
	Given I am on the home page
	When I fill in "Search" with "http://www.bbc.co.uk"
	And I press "Search"
	Then I should see "1 result"
	And I should see "http://www.bbc.co.uk"