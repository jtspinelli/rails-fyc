class YoutubeFavsController < ApplicationController
  add_flash_types :notice, :info, :error, :warning
  before_action :redirect_if_no_user, only: [:index, :new]

  def index
      @user = current_user
      @videos = current_user.videos.map { |video_document| YoutubeApi.resolve_video_data(video_document.video_id)}
  end
  
  def new
    @user = current_user
    @video = @user.videos.new
  end

  def create
    url = video_params[:url]
    video_id = resolve_video_id(url)

    if api_response(video_id).code == "200"
      if video_found?
        if not_in_collection?(video_id)
          current_user.videos.create(video_id: video_id)
          flash_message("success","Video added successfully", "/youtubefavs")
        else
          flash_message("error","Video already in the collection", "/youtubefavs/new")
        end
      else
        flash_message("error","Video not found (maybe corrupted id)", "/youtubefavs/new")
      end
    else
      flash_message("error", "Server could not respond", "/youtubefavs/new")
    end
  end

  def destroy
    video_id = params[:video_id]
    video = current_user.videos.find_by(video_id: video_id)
    video.destroy
    flash_message("success", "Video removed", "/youtubefavs")
  end

  def redirect_if_no_user
    redirect_to :root if session[:user_id].nil?
  end

  def user?
    !session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id])
  end

  def resolve_video_id(url)
    YoutubeApi.resolve_video_id(url)
  end

  def api_response(video_id)
    YoutubeApi.look_for_video(video_id)
  end

  def video_found?
    YoutubeApi.video_found?
  end

  def not_in_collection?(video_id)
    !current_user.videos.where(video_id:video_id).exists?
  end

  # Flashes given type message and redirects to given page
  # @param type [String] the flash message type (error, success)
  # @param error_message [String] message to be flashed
  # @param redirect_page [String] the relative path of the page to be redirected to
  def flash_message(type, error_message, redirect_page)
    flash[type] = error_message
    redirect_to redirect_page
  end

  private
  def video_params
    params.require(:video).permit("url", "video_id")
  end
end
