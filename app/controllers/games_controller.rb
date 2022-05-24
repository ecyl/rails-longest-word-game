require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[1..10]
  end

  def inside
    word = params[:word]
    word.chars.all? { |letter| word.count(letter) <= new.count(letter) }
  end

  def score
    word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    results = JSON.parse(word_serialized)

    if inside == false
        @message = "Sorry but #{word} can't be built out of #{@letters}"
    elsif results['found']
      @message = "Congratulations! #{word} is a valid English word!"
    else
      @message = "Sorry but #{word} does not seem to be a valid English word.."
    end

      # The word can’t be built out of the original grid
      # The word is valid according to the grid, but is not a valid English word
      # The word is valid according to the grid and is an English word
  end
end
