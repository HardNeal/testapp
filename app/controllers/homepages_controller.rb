class HomepagesController < ApplicationController
	require 'google/api_client'
  def index

  end

  def search
		my_string = params[:search][:text].downcase
		if my_string.include?("weather") || my_string.include?("погода")
		  result = Search::SearchWeather.call(string: my_string)
		  puts "in #{result.city} #{result.temperature.to_i} temperature"
		else 
			my_search_client = Google::APIClient.new
			google_search = my_search_client.discovered_api('customsearch')
			response = my_search_client.execute(
			  google_search.cse.list, 'q' => 'your query'
			)
			status, headers, body = response

		end
		redirect_to root_path
  end
end
