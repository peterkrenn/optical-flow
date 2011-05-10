require 'spec_helper'

describe VideosController do
  describe 'GET index' do
    it 'renders' do
      get :index
      response.should render_template 'index'
    end

    it 'exposes videos' do
      controller.should respond_to(:videos)
    end
  end
end
