Feature: Managing bookmarks
  In order to remember my bookmarks
  As a user
  I want to manage my bookmarks

Scenario: Adding a bookmark
	Given I go to the home page
	When I fill in the following: 
		| URL      | http://www.bbc.co.uk |
		| Tag list | news 								|
	And I press "Save bookmark"
	Then I should see "Bookmark saved"
	And I should see "http://www.bbc.co.uk"
	
Scenario: Viewing a bookmark
	Given the following bookmarks:
		| url 								 | tag_list |
		| http://www.bbc.co.uk | news 		|
	And I go to the home page
	When I follow "http://www.bbc.co.uk"
	Then I should see "news" within "#tags"