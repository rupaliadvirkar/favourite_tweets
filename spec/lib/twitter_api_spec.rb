require 'spec_helper'

describe TwitterApi do
	class DummyClass
	end

	before(:all) do
	    @dummy = DummyClass.new
    	@dummy.extend TwitterApi
    	query = "ruby on rails"
  		results_per_page = 100
  		@results = @dummy.twitter_search(query,results_per_page)
  	end

  	it "should search the result with given query string" do
  		@results.length.should > 0
  	end
    
    it "should parse the results from twitter and provide array of hash of search result object" do
    	parsed_results = @dummy.parse_searched_result(@results)
    	parsed_results.length.should > 0
    	parsed_results[0][:twitter_created_at].should_not be_nil
    	parsed_results[0][:from_user].should_not be_nil
    	parsed_results[0][:from_user_id].should_not be_nil
    	parsed_results[0][:profile_image_url].should_not be_nil
    	parsed_results[0][:text].should_not be_nil
	end
end