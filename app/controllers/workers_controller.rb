class WorkersController < ApplicationController
  respond_to :html
  expose(:workers) { Resque.workers }

  def index
    render :partial => 'workers', :locals => {:workers => workers}
  end
end
