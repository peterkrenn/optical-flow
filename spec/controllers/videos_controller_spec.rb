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

  pending 'PUT update' do
    context 'with valid params' do
      it 'enqueues the requested video' do
        video = double(Video)
        Video.should_receive(:find).with('file_name') { video }
        video.should_receive(:equeue)

        put :update, :file_name => 'file_name'
      end
    end
  end
end
