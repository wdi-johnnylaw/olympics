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
    let(:validity) {true}
    before :all do
      @post_params = {
        athlete: {
          first_name: 'John'
        }
      }
    end

    before :each do
      Athlete.any_instance.stub(:valid?).and_return(validity)
    end

    context 'when athlete is valid' do   ##### Happy path
      let(:validity) { true }

      it 'saves the athlete with the params given, sets a flash notice and redirects to the "index"' do
        post 'create', { athlete: { first_name: 'Michael' } }

        expect(flash[:notice]).to eq 'Yey! Your athlete saved successfully!'
        expect(response).to redirect_to athletes_path
        expect(assigns(:athlete)).to be_persisted
      end
    end

    context 'when athlete is NOT valid' do    ##### Sad path
      let(:validity) { false }

      it 'sets a flash error and re-renders the form' do
        post 'create', { athlete: { first_name: 'Michael' } }

        expect(flash[:error]).to eq 'Boo, no go!'
        expect(response).to render_template('new')
      end
    end

    context 'when every possible welcomed param is present' do
      let(:valid_params) do 
        {
          athlete: {
            first_name: "Johnny", 
            last_name:"Cash", 
            middle_name: "Lee",
            age: "22",
            sport: "Skiing",
            country: "USA"
          }
        } 
      end
      it 'the controller lets them all through' do
        post 'create', valid_params

        expect(assigns(:athlete).first_name).to eq "Johnny"
        expect(assigns(:athlete).last_name).to eq "Cash"
        expect(assigns(:athlete).middle_name).to eq "Lee"
        expect(assigns(:athlete).age).to eq 22
        expect(assigns(:athlete).sport).to eq "Skiing"
        expect(assigns(:athlete).country).to eq "USA"
      end
    end

    context 'when extra params are present' do
      it 'the extra params are dropped' do
        Athlete.should_receive(:new).with({}).and_call_original
        post 'create', { athlete: { bullshit: 'thing' } }
      end
    end

  end
end
