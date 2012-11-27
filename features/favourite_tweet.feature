Feature: Favourite tweets  
  In order to mark and save favourite tweets as a user.  		
     
    Background:
      Given I am logged in user
      
      Scenario: I mark and save my favourite tweets      
        And I have searched for "RoR" and favourited 3 tweets
      Then I should be redirected to "My Favourites" page
       And I should have 3 favourite tweets

      Scenario: I am on my favourites page when I have favourite tweets      
        And I have following in tweets table:
        | id | from_user | from_user_id | profile_image_url    | text   | twitter_created_at |
      | 1  | "1"       | 1            | "http://sample1.com" | "RoR"  | 2012-11-9          |
      | 2  | "2"       | 2            | "http://sample2.com" | "RoR1" | 2012-11-9          |
      | 3  | "3"       | 3            | "http://sample3.com" | "RoR2" | 2012-11-9          |
      | 4  | "4"       | 4            | "http://sample4.com" | "RoR3" | 2012-11-9          |
        And I have 3 favourite tweets
      When I follow "My Favourites"
      Then I should see "RoR"
        And I should see "RoR1"
        And I should see "RoR2"
        And I should not see "RoR3"

  		Scenario: I am on my favourites page when I have no favourite tweets  		
  		When I follow "My Favourites"
  		Then I should see "No favourite Tweets"
  			
      
        



