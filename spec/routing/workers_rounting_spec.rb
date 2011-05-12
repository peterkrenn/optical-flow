require 'spec_helper'

describe WorkersController do
  describe 'routing' do
    it 'recognizes and generates #index' do
      { :get => '/workers' }.should route_to :controller => 'workers', :action => 'index'
    end
  end
end

