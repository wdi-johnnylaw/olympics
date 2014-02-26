require 'spec_helper'

describe AthletesController do

  describe "GET 'index'" do
    it "returns http success" do
    	Athlete.stub(:all).and_return('an array of athletes')
      get 'index'
      response.should be_success
    	expect(assigns(:athletes)).to eq 'an array of athletes'
    end
  end

  describe "POST 'create'" do
    before :all do
      @post_params = {
        athlete: {
          first_name: 'John'
        }
      }
    end

    context 'when athlete is valid' do   ##### Happy path
      it 'saves the athlete with the params given, sets a flash notice and redirects to the "index"' do
        Athlete.any_instance.stub(:valid?).and_return(true)

        post 'create', { athlete: { first_name: 'Michael' } }

        expect(flash[:notice]).to eq 'Yey! Your athlete saved successfully!'
        expect(response).to redirect_to athletes_path
        expect(assigns(:athlete).first_name).to eq 'Michael'   # Remove this; move into own test
        expect(assigns(:athlete)).to be_persisted
      end
    end

    context 'when athlete is NOT valid' do    ##### Sad path
      it 'DOES NOT save the athlete, but it does have params; it sets a flash error and re-renders the form' do
        Athlete.any_instance.stub(:valid?).and_return(false)

        post 'create', { athlete: { first_name: 'Michael' } }

        expect(flash[:error]).to eq 'Boo, no go!'
        expect(response).to render_template('new')
      end
    end

    it 'assigns the appropriate params to the new athlete' do
    end
  end
end
