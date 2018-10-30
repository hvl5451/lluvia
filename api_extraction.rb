time=Time.new
require_relative 'hourly_weather_12'
require 'net/http'
require 'json'



# This class calls all the required API to collect the 12 hour weather data

class Api_Extraction

  # This method determines the latitude and longitude of the user via their IP address.
  def latitude_Longitude()

    url="http://ip-api.com/json"
    uri=URI(url)
    response=Net::HTTP.get(uri)
    latitude=JSON.parse(response)['lat']
    longitude=JSON.parse(response)['lon']
    #minutecast_obj=MinuteCast.new(latitude,longitude)

    # The latitude and longitude is passed as parameters to geoposition method which calculates the location key based on lat and lon
    geoposition(latitude,longitude)

  end

  # This method calculates the location key of the specified lat and lon by using the Accuweather geoposition API.
  # This location is key is passed to several other functions which corresponds to their respective API calls.
  def geoposition(latitude,longitude)

    url="http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=rLzJeVXzhcj0QRiXtnR7LZ11lEcw0sXc&q=#{latitude}%2C#{longitude}"
    uri=URI(url)
    response=Net::HTTP.get(uri)
    location_key=JSON.parse(response)['Key']

    # The location key is passed as parameters to hourly_Forecast method which retrieves the 12 hour forecast data
    hourly_Forecast(location_key)
    end

  # This method calculates the 12 hour forecast corresponding to the specified location key. This method calls the 12 hour forecast api to get the data.
  def hourly_Forecast(location_key)

    url="http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/#{location_key}?apikey=rLzJeVXzhcj0QRiXtnR7LZ11lEcw0sXc"
    uri = URI(url)
    response=Net::HTTP.get(uri)
    parsed_response=JSON.parse(response)
    Hourly_Forecast_Object_Creation(parsed_response)

  end

  # This method creates an object for parsed json response received from calling 12 hour weather forecast.
  # Each object will represent respective hour from the start time of the 12 hour API call.
  # The objects are instantiated from hourly_weather_12 class and the 12 objects are stored in an array
  # Returns the Hashmap containing keys as Hours and values as weather

  def Hourly_Forecast_Object_Creation(response)

    #array that stores the instantiated objects of hourly_weather_12 class
    # First element stores the weather details of the 1st hour
    # 12th element stores the weather details of the 12th
    obj_Array=[]


    for i in 0..11 do
      # retrieving the hour of the data from Date time field in the JSON object of the 12 hour API call
      hour=response[i]["DateTime"]
      id = hour[11..12]

      iconPhrase=response[i]["IconPhrase"]
      isDayLight=response[i]["IsDaylight"]
      temperature=response[i]["Temperature"]["Value"]

      #object is instantiated
      new_obj=HourlyWeather_12.new(iconPhrase, isDayLight, temperature, id)

      #object is pushed into the object array
      obj_Array.push(new_obj)
    end
    return weather_Map(obj_Array)
  end

  # This method takes in the object array and converts it into a Hash map where the id of that hour is the key and the weather fot that specific hour is the value.
  # Returns the Hashmap to Hourly_Forecast_Object_Creation
  def weather_Map(arr)
    weather_map_12hr={}
    arr.each {|item| weather_map_12hr[item.get_id] = item.get_iconPhrase }

    return weather_map_12hr
  end


# An object of API extraction is created for testing
  caller_1=Api_Extraction.new
  caller_1.latitude_Longitude
end



#  @@url1="http://ip-api.com/json"
# uri1=URI(@@url1)
# response1=Net::HTTP.get(uri1)
# @@check_ip=JSON.parse(response1)['query']
#
# def self.update
#   obj1=Api_Extraction.new
# loop do
#   foo=true
#   if foo
#     obj1.latitude_longitude()
#   end
#   uri2=URI(@@url1)
#   response2=Net::HTTP.get(uri2)
#   ip_address=JSON.parse(response2)
#   if ip_address!=@@check_ip
#     obj1.latitude_longitude
#   end
# end
# end
