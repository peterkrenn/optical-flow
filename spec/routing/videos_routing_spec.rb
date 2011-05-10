require 'spec_helper'

describe VideosController do
  describe 'routing' do
    it 'recognizes and generates #index' do
      { :get => '/videos' }.should route_to :controller => 'videos', :action => 'index'
      { :get => '/' }.should route_to :controller => 'videos', :action => 'index'
    end
  end
end
