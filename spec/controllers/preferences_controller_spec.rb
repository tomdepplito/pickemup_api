require 'spec_helper'

describe PreferencesController do
  before :all do
    `rake db:test:prepare`
  end

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @params = {'preference' => {'locations' => ['San Francisco'], 'skills' => ['Ruby'],
                                'user_id' => FactoryGirl.generate(:random_id),
                                'preference_id' => FactoryGirl.generate(:random_id)}}
  end

  describe '#create' do
    context 'when a POST request is made with valid params' do
      it 'should create a new preference' do
        preference_count = Preference.count
        post :create, @params
        response.status.should == 200
        Preference.count.should == preference_count + 1
      end
    end
  end

  context 'when a preference exists' do
    before :each do
      @preference = FactoryGirl.create(:preference)
      @params['preference'].merge!('user_id' => @preference.user_id)
    end

    describe '#update' do
      context 'when a POST request is made with valid params to the update action' do
        it 'should update the preference' do
          post :update, @params
          response.status.should == 200
          updated_preference = Preference.find("user_id: #{@preference.user_id}")
          updated_preference.skills.should == ['Ruby']
          updated_preference.locations.should == ['San Francisco']
        end
      end
    end

    describe '#destroy' do
      context 'and a POST request is made with valid params to the destroy action' do
        it 'should delete the preference' do
          post :destroy, @params
          response.status.should == 200
          Preference.find("user_id: #{@preference.user_id}").should == nil
        end
      end
    end

    describe '#retrieve' do
      context 'and a GET request is made with valid params to the retrieve action' do
        before :each do
          FactoryGirl.create(:preference, :skills => ['C++', 'Ruby'], :locations => ['San Francisco', 'New York'])
          FactoryGirl.create(:preference, :skills => ['Clojure', 'Python'], :locations => ['San Francisco', 'Portland'])
          FactoryGirl.create(:preference, :skills => ['Python'], :locations => ['San Francisco'])
          @params = {'preference' => {'locations' => ['San Francisco'], 'skills' => ['Python']}}
        end

        it 'should find all matching job listings' do
          get :retrieve, @params
          results = JSON.parse(response.body)
          results.count == 2
          results.should be_a_kind_of Array
        end
      end
    end
  end

  describe '#update_scores' do
    context 'when a preference changes' do
      it 'should update the scores for all relevant job listings' do
        @params = {'preference' => {'preference_id' => 'some_job_listing_id'}}
        UpdateRelevantListingMatchesWorker.should_receive(:perform_async).with(@params['preference']['preference_id'])
        post :update_scores, @params
      end
    end
  end
end
