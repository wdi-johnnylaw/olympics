class AthletesController < ApplicationController
  def index
  	@athletes = Athlete.all
  end

  def create
  	@athlete = Athlete.new(params.require(:athlete).permit(:first_name, :last_name))
  	if @athlete.save
  		flash[:notice] = 'Yey!'
	  	redirect_to @athlete
  	else
  		flash[:error] = 'Boo'
  		render action: 'new'
  	end
  end
end
