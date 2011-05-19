require 'spec_helper'

describe WorkersController do
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
