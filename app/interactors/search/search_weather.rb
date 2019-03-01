require 'open-uri'
require 'uri'
require 'net/https'
require 'net/http'
require 'json'

module Search
  class SearchWeather
    include Interactor
    def call
      apikey = ENV['APIKEY']
      string = context.string
      check_string_to_city_name(string, apikey)
    end

    def check_string_to_city_name(string, apikey)
      string = string.split(' ')
      string.each do |str|
        url = "http://api.openweathermap.org/data/2.5/weather"
        uri = URI.parse(url)
        result = Net::HTTP.start(uri.host, uri.port) { |http| http.get("#{uri.path}?q=#{str}&appid=#{apikey}") }
        if result.code.to_i < 400
          @result = check_weather(str, apikey)
        end
      end
    end

    def check_weather(string, apikey)
    	response = open("http://api.openweathermap.org/data/2.5/weather?q=#{string}&appid=#{apikey}").read
	    parsed_json = ActiveSupport::JSON.decode(response)
	    temperature = parsed_json["main"]["temp"]
      city = parsed_json["main"]["temp"]
	    context.temperature = temperature
      context.city = string
    end
  end
end