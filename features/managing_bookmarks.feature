Feature: Managing bookmarks
  In order to remember my bookmarks
  As a user
  I want to manage my bookmarks

Scenario: Adding a bookmark
	Given I go to the home page
	When I fill in the following: 
		| URL  | http://www.bbc.co.uk |
		| Tags | news 								|
	And I press "Save bookmark"
	Then I should see "Bookmark saved"
	And I should see "http://www.bbc.co.uk"