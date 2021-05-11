class AddedGamesController < ApplicationController
  before_action :set_tracker, only: %i[new create destroy]

  def new
    @addedgame = AddedGame.new
    authorize @addedgame
  end

  def create
    @addedgame = AddedGame.new(added_game_params)
    @addedgame.tracker = @tracker
    authorize @addedgame
    if @addedgame.save
      flash[:notice] = "#{@addedgame.game.title} successfully added to #{@tracker.name}"
      redirect_to tracker_path(@tracker)
    else
      flash[:alert] = "This game might already be in this tracker. If not, try again later or contact support."
      redirect_to new_tracker_added_game_path(@tracker)
    end
  end 

  def destroy
    @addedgame = AddedGame.find(params[:id])
    authorize @addedgame
    if @addedgame.destroy
      flash[:notice] = "#{@addedgame.game.title} successfully removed from #{@addedgame.tracker.name}"
      redirect_to tracker_path(@tracker)
    else
      flash[:alert] = "Something went wrong. Try again later."
      redirect_to edit_tracker_path(@tracker)
    end
  end

  private

  def added_game_params
    params.require(:added_game).permit(:game_id)
  end

  def set_tracker
    @tracker = Tracker.find(params[:tracker_id])
    authorize @tracker
  end
end
