require 'spec_helper'

describe WorkersController do
  it 'exposes workers' do
    controller.should respond_to(:workers)
    Resque.should_receive(:workers)
    controller.workers
  end

  describe 'GET index' do
    it 'is successful' do
      get :index
      response.should be_successful
    end

    it 'renders' do
      get :index
      response.should render_template 'index'
    end
  end
end
