class PreferencesController < ApplicationController
  def update_preference
    preference = Preference.find("user_id: #{params[:preference].slice!(:user_id)}")
    preference.update_attributes(preference_params)
  end

  def preference_params
    params.require(:preference).permit!
  end
end
