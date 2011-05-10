require 'spec_helper'

describe VideosController do
  describe 'GET index' do
    it 'should render' do
      get :index
      response.should render_template 'index'
    end

    it 'should expose videos' do
      controller.should respond_to(:videos)
    end
  end
end
