class AthletesController < ApplicationController
  def index
  	@athletes = Athlete.all
  end

  def create
    @athlete = Athlete.new(params.require(:athlete).permit!)#(:first_name, :last_name, :middle_name, :age, :sport, :country))
    if @athlete.save
      flash[:notice] = 'Yey! Your athlete saved successfully!'
      redirect_to athletes_path
    else
      flash[:error] = 'Boo, no go!'
      render action: 'new'
    end
  end
end
