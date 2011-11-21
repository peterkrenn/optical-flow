class VideosController < ApplicationController
  expose(:videos) { Video.all }
  expose(:video)

  def index
    render :layout => false if request.xhr?
  end

  def new
    render :layout => false if request.xhr?
  end

  def create
    params[:video][:original_filename] = params[:video][:original_video].original_filename
    video.save
    redirect_to :action => 'index'
  end

  def update
    video.async_process
    render :nothing => true
  end
end
