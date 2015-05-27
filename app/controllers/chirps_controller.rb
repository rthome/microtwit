class ChirpsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @chirp = current_user.chirps.build(chirp_params)
    if @chirp.save
      flash[:success] = 'Chirp posted!'
      redirect_to root_url
    else
      @feed_entries = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy

  end

  private

    def chirp_params
      params.require(:chirp).permit(:content)
    end

end
