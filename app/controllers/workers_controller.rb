class WorkersController < ApplicationController
  respond_to :html
  expose(:workers) { Resque.workers }

  def index
    render :layout => false if request.xhr?
  end
end
