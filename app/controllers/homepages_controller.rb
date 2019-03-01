class HomepagesController < ApplicationController
  def index

  end

  def search
		my_string = params[:search][:text].downcase
		if my_string.include?("weather") || my_string.include?("погода")
		  result = Search::SearchWeather.call(string: my_string)
		  @text = "in #{result.city} #{result.temperature.to_i} temperature"
		else
			result = Search::SearchWiki.call(string: my_string)

			@text = "#{result.title} \n #{result.description}"
		end
		if result.success?
			respond_to do |format|
	      format.html { redirect_to root_path, notice: 'find.' }
	      format.json { render :index, status: :created, location: @text }
	      format.js
	    end
    end
  end
end
