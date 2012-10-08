require 'twitter'

#This is  module for twitter api
module TwitterApi
  #This will create the search object.
  #Then will connect to twitter and will search the given text and return responce.
  def twitter_search(query_string,results_per_page)
    obj_search = Twitter::Client.new()
    searched_results = obj_search.search(query_string, :rpp => results_per_page, :result_type => "mixed").results
    searched_results
  end
  
  #This method will parse searched results
  def parse_searched_result(searched_results)
    parsed_search_results = []
    searched_results.map.each do |status|
      parsed_search_results << {:twitter_created_at => status.created_at.to_s,
                                :from_user => status.from_user,
                                :from_user_id => status.from_user_id,
                                :profile_image_url => status.profile_image_url,
                                :text => status.text}
    end
    parsed_search_results
  end
  
  #This will return the response from twitter for search query
  def search_api(query_string,results_per_page=100)
    searched_results = twitter_search(query_string.strip,results_per_page)
    parsed_search_results = parse_searched_result(searched_results)
    parsed_search_results
  end
end