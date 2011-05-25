require 'spec_helper'

describe VideosController do
  describe 'routing' do
    it 'recognizes and generates #index' do
      { :get => '/videos' }.should route_to :controller => 'videos', :action => 'index'
      { :get => '/' }.should route_to :controller => 'videos', :action => 'index'
    end

    pending 'recognizes and generates #update' do
      { :put => '/videos/1' }.should
        route_to(:controller => 'videos', :action => 'update', :id => '1')
    end
  end
end
