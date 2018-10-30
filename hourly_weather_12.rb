
# This is the 12 Hour Forecast Class.
# The objects of this class represents the weather, temperature, and the daylight of a specific location.

class HourlyWeather_12

  # Here the instance variable iconPhrase represents the weather of that particular hour
  # Instance variable id represents the particular hour. For eg, if an object is stored with weather data at 10:00, then the id of the object will be 10
  def initialize(iconPhrase, isDayLight, temperature,id)
    @iconPhrase=iconPhrase
    @isDayLight=isDayLight
    @temperature=temperature
    @id = id
  end

  # returns the id of the instance
  def get_id
    return @id
  end

  # returns the weather of the hour
  def get_iconPhrase
    return @iconPhrase
  end

  # returns a boolean value indicating whether it's daylight or not. True - Daylight
  def get_IsDayLight
    return @isDayLight
  end

  # returns the temperature of the hour
  def get_Temperature
    return @temperature
  end

  # returns a list consisting of weather, temperature and daylight info about the hour
  def results()
    result=[@iconPhrase, @temperature, @isDayLight]
    return result
  end
end



