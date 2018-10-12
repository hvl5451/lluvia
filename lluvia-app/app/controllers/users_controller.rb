require 'accuweather'
require 'rspotify'
require 'geocoder'
require 'net/http'
require 'json'

class UsersController < ApplicationController

  def callback
    $spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    user_email = $spotify_user.email

    query = User.search(user_email)

    if query.any?
    else
      #user is new
      User.create(:email => user_email)
    end

    redirect_to home_path
  end

  def login
    puts "KEY: " + ENV["SPOTIFY_CLIENT_ID"]
  end

  def home
  end

  def generate_playlist

    @moods = {"sunny"=>{"valence"=>0.85, "energy"=>0.85, "tempo"=>180, "acousticness"=>0.15, "size" => 0},
                "partlycloudy"=>{"valence"=>0.8, "energy"=>0.75, "tempo"=>140, "acousticness"=>0.2,"size" => 0},
                "cloudy"=>{"valence"=>0.5, "energy"=>0.5, "tempo"=>80, "acousticness"=>0.25,"size" => 0},
                "lightrain"=>{"valence"=>0.2, "energy"=>0.35, "tempo"=>70, "acousticness"=>0.3,"size" => 0},
                "heavyrain"=>{"valence"=>0.1, "energy"=>0.45, "tempo"=>85, "acousticness"=>0.25,"size" => 0}}
    #get location & weather data from Accuweather




    #get song library of user from spotify API
    RSpotify::authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

    playlists = $spotify_user.playlists()
    songs = Array.new()

    playlists.each { |playlist| songs.push(*playlist.tracks)}

    redirect_to show_playlist_path
  end

  def show_playlist

  end

end
