require 'net-ssh'
require 'rest-client'
require 'json'

class WeathersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :prim2poppy ]

  def say(message)
    Net::SSH.start('#{ENV[POPPY_WEB]}', 'poppy', password: "poppy") do |ssh|
      output = ssh.exec!("echo '#{message}' | espeak -vfr+m1 -s 100 -p 50")
      puts output
    end
  end

  def weather(id)
    weather = {
      "1" => {
      text: "fait grand soleil",
      emoji: "☀️"
      },
      "2" => {
      text: "y a quelques nuages",
      emoji: "⛅️"
      },
      "3" => {
        text: "y a des nuages éparses",
        emoji: "☁️"
      },
      "4" => {
        text: "y a des nuages fragmentés",
        emoji: "☁️"
      },
      "9" => {
        text: "pleut comme vache qui pisse", # pluie battante
        emoji: "🌧"
      },
      "10" => {
        text:  "pleut",
        emoji: "🌧"
      },
      "11" => {
        text:  "y a un gros orage",
        emoji: "🌩"
      },
      "13" => {
        text:  "neige",
        emoji: "🌨"
      },
      "50" => {
        text:  "y a du brouillard, on n'y voit rien",
        emoji: "🌫"
      }
    }
    return weather[id]
  end

  def get_meteo(city, country)
    url = "http://api.openweathermap.org/data/2.5/forecast/city?q=#{city}&units=metric&APPID=#{ENV[OPEN_WEATHER_MAP]}"
    response = RestClient.get(url)
    data = JSON.parse(response)["list"].first
    icon_id = data["weather"].first["icon"].to_i.to_s
    temp = data["main"]["temp"].to_i
    {
      weather: weather(icon_id),
      temp: temp
    }
  end

  def meteo
    get_meteo(params[:city])
    render json: {
     messages: [
       { text: "#{city}: #{weather[:weather][:emoji]} #{weather[:temp]}°C"}
     ]
    }
  end
end


# My version, under construction, used Sylvains's one

#   def get_meteo
#     @city = params[:city]
#     @country = params[:country]
#     call_weather(@city, @country)
#   end

# private

#   # Weathers  API call
#   # ------------------
#   def call_weather(city, country)

#     avec country: uri = "http://api.openweathermap.org/data/2.5/forecast/city?q=#{city},#{country}&units=metric&APPID=#{ENV[OPEN_WEATHER_MAP]}"

#     weather_uri = "http://api.openweathermap.org/data/2.5/weather?q="
#     weather_api_key = ENV["OPEN_WEATHER_MAP"]
#     uri = "#{weather_uri}#{@city},#{@country}&APPID=#{weather_api_key}&units=metric"
#     response = RestClient.get uri
#     { result: response.code, answer: JSON.parse(response.body) }
#   end

# TEST
# city = "La Havane"
# weather = get_meteo(city)

# puts "#{city}: #{weather[:weather][:emoji]} #{weather[:temp]}°C"
# message = "à #{city}, il #{weather[:weather][:text]} et il fait #{weather[:temp]} degrés"
# say(message)


