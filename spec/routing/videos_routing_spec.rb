require 'spec_helper'

describe VideosController do
  describe 'routing' do
    it 'routes to #index' do
      { :get => '/videos' }.should route_to :controller => 'videos', :action => 'index'
    end

    it 'routes to #new' do
      { :get => '/videos/new' }.should route_to :controller => 'videos', :action => 'new'
    end

    it 'routes to #create' do
      { :post => '/videos' }.should route_to :controller => 'videos', :action => 'create'
    end

    it 'routes to #update' do
      { :put => '/videos/1' }.should
        route_to(:controller => 'videos', :action => 'update', :id => '1')
    end
  end
end
