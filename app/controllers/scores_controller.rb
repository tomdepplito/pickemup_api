require 'torquebox-messaging'
class ScoresController < ApplicationController
  def update_all_scores
    if UpdateAllScores.new.start
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end
end
