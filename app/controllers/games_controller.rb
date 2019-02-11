require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)

  end
  def scores
    @answer = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_serialized = open(url).read
    @user = JSON.parse(user_serialized)
    isEnglish = @user["found"]
    @letters = params[:letters]

    isInGrid = @answer.chars.all? { |letter| @letters.count(letter) >= @answer.count(letter)}

    if isInGrid == false
      @result = "Sorry but #{@answer} can't be built out of #{@letters}"
    elsif isInGrid == true && isEnglish == false
      @result = 'Yes #{answer} valid but not an English word'
    else
      @result ='Yes is perfect!'
    end
  end
end
