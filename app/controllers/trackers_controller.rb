class TrackersController < ApplicationController
  before_action :set_tracker, only: %i[show edit update destroy]

  def new
    @tracker = Tracker.new
    authorize @tracker
  end

  def create
    @tracker = Tracker.new(tracker_params)
    @tracker.user = current_user
    authorize @tracker
    if @tracker.save
      flash[:notice] = "#{@tracker.name} successfully created!"
      redirect_to dashboard_path
    else
      flash[:alert] = "Something went wrong. Please try again."
      redirect_to new_tracker_path
    end
  end

  def show; end

  def edit
    @addedgames = AddedGame.where(tracker: @tracker)
  end

  def update
    if @tracker.update(tracker_params)
      flash[:notice] = "#{@tracker.name} successfully updated"
      redirect_to tracker_path(@tracker)
    else
      flash[:alert] = "Somethign went wrong and #{@tracker.name} could not be updated. Please try again"
      redirect_to edit_tracker_path(@tracker)
    end
  end

  def destroy
    if @tracker.destroy
      flash[:notice] = "#{@tracker.name} successfully deleted"
      redirect_to dashboard_path
    else
      flash[:alert] = "#{@tracker.name} could not be deleted. Please try again"
      redirect_to tracker_path(@tracker)
    end
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:id])
    authorize @tracker
  end

  def tracker_params
    params.require(:tracker).permit(:name)
  end
end
