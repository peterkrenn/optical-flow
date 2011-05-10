require 'spec_helper'

describe 'videos/index.html.haml' do
  let(:videos) { [double('Video', :file_name => 'file_name')] }

  it 'displays all videos' do
    view.should_receive(:videos).once.and_return(videos)

    render

    rendered.should have_selector 'li', :count => 1
  end
end
