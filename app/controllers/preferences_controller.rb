class PreferencesController < ApplicationController
  def update_preference
    pref_params = params[:preference]
    preference = Preference.find("user_id: #{pref_params.slice!(:user_id)}")
    if preference.update_attributes(pref_params)
      respond_with 200
    else
      respond_with 500
    end
  end

  def retrieve_preferences
    preferences = Preference.all.query(:remote => query_params[:remote], :us_citizen => query_params[:us_citizen], :fulltime => query_params[:fulltime])
    preferences.select! do |preference|
      ((preference.locations & query_params[:locations]).count >= 1) && ((preference.skills & query_params[:skills]).count >= 1)
    end
    @user_ids = preferences.map{ |preference| preference.user_id }
    if @user_ids.count > 0
      respond_with @user_ids
    else
      respond_with 500
    end
  end

  private

  def preference_params
    params.require(:preference).permit!
  end

  def query_params
    params.require(:query).permit!
  end
end
