class VideosController < ApplicationController
  respond_to :html
  expose(:videos) { Video.all }
  expose(:video)

  def create
    video.save
    respond_with(videos)
  end
end
