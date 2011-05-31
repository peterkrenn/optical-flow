class VideosController < ApplicationController
  respond_to :html
  expose(:videos) { Video.all }
  expose(:video)

  def create
    video.save
    redirect_to :action => 'index'
  end

  def update
    video.async_process
    redirect_to :action => 'index'
  end
end
