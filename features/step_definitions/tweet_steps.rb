#####utilty methods
def sign_in
  @user = FactoryGirl.create(:user, :email => "example@example.com", :password => 'password')
  visit '/users/sign_in'
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
  click_button "Sign in"
end

def search(query)
  visit search_tweets_path()
  fill_in "query", :with => query
  click_button "Search"
end	


###Transform

Transform /^(should|should not)$/ do |should_or_not|
  should_or_not.gsub(' ', '_').to_sym
end

#####Given
Given /^I am logged in user$/ do
 sign_in
end

Given /^I am on (.+)$/ do |page_name|
	visit search_tweets_path()
end	

Given /^I have following in tweets table:$/ do |table|
  table.hashes.each do |attributes|
    Tweet.create!(attributes)
  end
end

Given /^I have searched for "([^\"]*)" and favourited (\d+) tweets$/ do |query,no_of_tweets|  
  search(query)
  i= 0
  while i < no_of_tweets.to_i
  	(page.all(:xpath, "//input[@id='tweets_to_be_added_']")[i]).set(true)
  	i += 1
  end
  click_button "Add to favourite"
end	

#####When

When /^I follow "([^\"]*)"$/ do |link|
  click_link(link)
end


When /^I have (\d+) favourite tweets$/ do |no_of_tweets|
  @user.tweets << Tweet.limit(no_of_tweets.to_i)
end

When /^I search for "([^\"]*)"$/ do |query|
  search(query)
end  

######Then
Then /^I (should|should not) see "([^\"]*)"$/ do |should_or_not,text|
  page.send should_or_not, have_content(text)
end

Then /^I (should|should not) see checkbox "([^\"]*)"$/ do |should_or_not,field|
  page.send should_or_not, have_xpath("//input[@id='#{field}']")
end

Then /^I (should|should not) see "([^\"]*)" button$/ do |should_or_not,label|
  page.send should_or_not, have_xpath("//button[@title='#{label}']")
end

Then /^I should be redirected to (.*) page$/ do |page|
	if page == "My Favourites"
		page.current_url.should == my_favourites_tweets_path()
	end	
end	

Then /^I should have (\d+) favourite tweets$/ do |no_of_tweets|	
	page.all('li').length.should == no_of_tweets.to_i
end