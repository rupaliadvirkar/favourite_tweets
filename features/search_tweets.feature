Feature:
  In order to search tweet

    Scenario Outline: searching tweets as guest
  		Given I am on search Page
  	  When I search for "<query>"
  		Then I should see "Results for <query>"
  			And I should not see checkbox "tweets_to_be_added[]"
  			And I should not see "Add to favourite" button
        And I should not see "My Favourites"        
      Examples:
        |query|
        |RoR|
        |ruby|

    Scenario Outline: searching tweets as valid user
      Given I am logged in user
        And I am on search Page
      When I search for "<query>"
      Then I should see "Results for <query>"
        And I should see "My Favourites"
      Examples:
        |query|
        |RoR|
        |ruby|