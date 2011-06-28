class WorkersController < ApplicationController
  expose(:workers) { Resque.workers }

  def index
  end
end
