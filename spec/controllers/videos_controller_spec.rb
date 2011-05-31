require 'spec_helper'

describe VideosController do
  it 'exposes videos' do
    controller.should respond_to(:videos)
    Video.should_receive(:all)
    controller.videos
  end

  it 'exposes video' do
    controller.should respond_to(:video)

    Video.should_receive(:new).once
    controller.video

    controller.stub(:params) { {:id => '1'} }
    Video.should_receive(:find).once.with('1')
    controller.video
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

  describe 'GET new' do
    it 'is successful' do
      get :new
      response.should be_successful
    end

    it 'renders' do
      get :index
      response.should render_template 'index'
    end
  end

  describe 'POST create' do
    it 'creates a new video' do
      expect { post :create, :video => {:original_video => 'original_video'} }.to change(Video, :count).by(1)
    end

    it 'redirects to index' do
      post :create, :file => 'file'
      response.should redirect_to :action => 'index'
    end
  end

  describe 'PUT update' do
    let(:video) { Fabricate(:video) }

    it 'processes the requested video asynchronously' do
      Video.should_receive(:find).with(video.id) { video }
      video.should_receive(:async_process)

      put :update, :id => video.id
    end

    it 'redirects to index' do
      put :update, :id => video.id
      response.should redirect_to :action => 'index'
    end
  end
end
