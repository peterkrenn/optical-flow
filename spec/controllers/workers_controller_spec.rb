require 'spec_helper'

describe WorkersController do
  before(:each) do
    Resque.stub(:workers) { }
  end

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
      response.should render_template 'workers'
    end
  end
end
