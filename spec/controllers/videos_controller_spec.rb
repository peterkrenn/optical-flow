require 'spec_helper'

describe VideosController do
  describe 'GET index' do
    it 'should render' do
      get :index
      response.should render_template 'index'
    end
  end
end
