require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
     @array = Array.new(10) { [*"A".."Z"].sample }
  end

  def true_false(attempt, grid)
    # raise
    # attempt = params['answer']

  hello = grid.split("")
  intersection = hello.map(&:downcase)

  attempt_hash = Hash.new(0)
  grid_hash = Hash.new(0)

  attempt.chars.each { |attempt_element| attempt_hash[attempt_element] += 1 }

  intersection.each { |grid_element| grid_hash[grid_element] += 1 }

  attempt.chars.uniq.each do |att_element|
    return false if grid_hash[att_element].nil?
    return false if (grid_hash[att_element] - attempt_hash[att_element]).negative?
  end
    return true
  end

  def json(attempt)
    # raise
  # attempt = params['answer']
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  word_serialized = open(url).read
  word = JSON.parse(word_serialized)
  if word["found"] == true
    return true
  else
    return false
  end
end

  def run_game(attempt, grid)
    result = (attempt.chars.size.to_f / grid.size) * 10
  if true_false(attempt, grid) == true && json(attempt) == true
    @score = { score: result, message: "well done" }
  elsif true_false(attempt, grid) == false
    @score = { score: 0, message: "not in the grid" }
  else
    @score = { score: 0, message: "not an english word" }
  end
end

  def score
    raise
    attempt = params[:answer]
    grid = params[:grid]
    run_game(attempt, grid)
  end

end
