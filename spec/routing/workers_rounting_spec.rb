require 'spec_helper'

describe WorkersController do
  describe 'routing' do
    it 'routes to #index' do
      { :get => '/workers' }.should route_to :controller => 'workers', :action => 'index'
    end
  end
end

