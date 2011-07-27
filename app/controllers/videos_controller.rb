class VideosController < ApplicationController
  expose(:videos) { Video.all }
  expose(:video)

  def create
    video.save
    redirect_to :action => 'index'
  end

  def update
    video.async_process
    render :nothing => true
  end
end
