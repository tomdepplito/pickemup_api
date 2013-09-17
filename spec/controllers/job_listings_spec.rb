require 'spec_helper'

describe JobListingsController do
  before :all do
    `rake db:test:prepare`
  end

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @params = {'job_listing' => {'locations' => ['San Francisco'], 'skills' => ['Ruby'],
                                 'expiration_time' => Time.now.to_s,
                                 'job_listing_id' => FactoryGirl.generate(:random_id),
                                 'company_id' => FactoryGirl.generate(:random_id)}}
  end

  describe '#create' do
    context 'when a POST request is made with valid params' do
      it 'should create a new job listing' do
        job_listing_count = JobListing.count
        post :create, @params
        response.status.should == 200
        JobListing.count.should == job_listing_count + 1
      end
    end
  end

  context 'when a job listing exists' do
    before :each do
      @listing = FactoryGirl.create(:job_listing)
      @params['job_listing'].merge!('job_listing_id' => @listing.job_listing_id)
    end

    describe '#update' do
      context 'when a POST request is made with valid params to the update action' do
        it 'should update the job listing' do
          post :update, @params
          response.status.should == 200
          updated_listing = JobListing.find("job_listing_id: #{@listing.job_listing_id}")
          updated_listing.skills.should == ['Ruby']
          updated_listing.locations.should == ['San Francisco']
        end
      end
    end

    describe '#destroy' do
      context 'and a POST request is made with valid params to the destroy action' do
        it 'should delete the job listing' do
          post :destroy, @params
          response.status.should == 200
          JobListing.find("job_listing_id: #{@listing.job_listing_id}").should == nil
        end
      end
    end

    describe '#retrieve' do
      context 'and a GET request is made with valid params to the retrieve action' do
        before :each do
          FactoryGirl.create(:job_listing, :skills => ['C++', 'Ruby'], :locations => ['San Francisco', 'New York'])
          FactoryGirl.create(:job_listing, :skills => ['Clojure', 'Python'], :locations => ['San Francisco', 'Portland'])
          FactoryGirl.create(:job_listing, :skills => ['Python'], :locations => ['San Francisco'])
          @params = {'job_listing' => {'locations' => ['San Francisco'], 'skills' => ['Python']}}
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
end
