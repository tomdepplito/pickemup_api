class PreferencesController < ApplicationController
  require 'string'
  respond_to :json, :html
  def update
    pref_params = params['preference']
    preference = Preference.find("user_id: #{preference_params['user_id']}")
    if preference && preference.update_attributes(preference_params)
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def retrieve
    preferences = Preference.all.query(initial_query_params)
    if preferences.count > 0
      all_preferences = preferences.to_a
      all_preferences.select! do |preference|
        ((preference.locations & array_query_params['locations']).count >= 1) && ((preference.skills & array_query_params['skills']).count >= 1)
      end
      @user_ids = all_preferences.map{ |preference| preference.user_id }
      if @user_ids.count > 0
        render json: @user_ids
      else
        render text: "Action Failed", status: 500
      end
    else
      render json: []
    end
  end

  def create
    preference = Preference.create(preference_params)
    if preference && preference.save
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def destroy
    preference = Preference.find("user_id: #{params['user_id']}")
    if preference && preference.destroy
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  private

  def preference_params
    params.require('preference').permit!
  end

  def initial_query_params
    search_params = {}
    search_params.merge!(params.require('preference').permit!.select { |key, val| val.class.name != "Array"})
  end

  def array_query_params
    search_params = {"locations" => [], "skills" => []}
    params.require('preference').permit!.each do |key, val|
      search_params.merge!(key => val) if val.class.name == 'Array'
    end
    search_params
  end
end
