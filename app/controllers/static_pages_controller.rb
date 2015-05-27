class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @chirp = current_user.chirps.build
      @feed_entries = current_user.feed.paginate(page: params[:page])
    end
  end
end
