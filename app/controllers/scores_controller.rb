require 'torquebox-messaging'
class ScoresController < ApplicationController
  def update_all_scores
    puts "hit update all scores controller"
    UpdateAllScores.new.start
    render text: "OK", status: 200
  end
end
