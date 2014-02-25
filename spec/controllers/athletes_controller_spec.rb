require 'spec_helper'

describe AthletesController do

  describe "GET 'index'" do
    it "returns http success" do
    	Athlete.should_receive(:all).and_return('an array of athletes')
      get 'index'
      response.should be_success
    	expect(assigns(:athletes)).to eq 'an array of athletes'
    end
  end

  describe "POST 'create'" do
  	context 'record can save' do
	  	it 'creates a mf and redirects to the show path' do
	  		athlete = Athlete.new
	  		athlete.stub(:id).and_return(5)
	  		athlete.stub(:save).and_return true
	  		athlete.stub(:persisted?).and_return(true)
	  		Athlete.should_receive(:new).with('first_name' => 'Papa', 'last_name' => 'Diggs').and_return(athlete)
	  		controller.should_receive(:redirect_to).with(athlete)

	  		post 'create', { athlete: { first_name: 'Papa', last_name: 'Diggs' }}

	  		response.should redirect_to athlete
	  		binding.pry
	  	end
  end

end
