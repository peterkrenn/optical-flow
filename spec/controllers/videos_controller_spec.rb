require 'spec_helper'

describe VideosController do
  describe 'GET index' do
    it 'is successful' do
      get :index
      response.should be_successful
    end

    it 'renders' do
      get :index
      response.should render_template 'index'
    end

    it 'exposes videos' do
      controller.should respond_to(:videos)
      Video.should_receive(:all)
      controller.videos
    end
  end
end
