Feature: Managing bookmarks
  In order to remember my bookmarks
  As a user
  I want to manage my bookmarks

Scenario: Adding a bookmark
	Given I go to the home page
	When I fill in the following: 
		| URL      | http://www.bbc.co.uk |
		| Tags     | news 								|
	And I press "Save bookmark"
	Then I should see "Bookmark saved"
	And I follow "http://www.bbc.co.uk"
	And I should see "news" within "#tags"
	
Scenario: Viewing all the main sites for bookmarks
	Given the following bookmarks:
		| url        									 |
		| http://www.bbc.co.uk  			 |
		| http://news.bbc.co.uk 			 |
		| http://www.bbc.co.uk/iplayer |
	And I am on the home page
	When I follow "View all sites"
	Then I should see "www.bbc.co.uk"
	And I should see "news.bbc.co.uk"
	
Scenario: Viewing all bookmarks for a given site
	Given the following bookmarks:
		| url        									 |
		| http://www.bbc.co.uk  			 |
		| http://news.bbc.co.uk 			 |
		| http://www.bbc.co.uk/iplayer |
	And I am on the home page
	When I follow "View all sites"
	And I follow "www.bbc.co.uk"
	Then I should see "http://www.bbc.co.uk"
	And I should see "http://www.bbc.co.uk/iplayer"