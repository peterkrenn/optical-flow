require 'spec_helper'

describe 'videos/index.html.haml' do
  context 'with videos' do
    let(:videos) { [stub_model(Video, :file_name => 'video.mov')] }

    it 'displays all videos' do
      view.should_receive(:videos).once.and_return(videos)
      render
      rendered.should have_selector 'ul' do |ul|
        ul.should have_selector 'li', :count => 1, :content => 'video.mov'
      end
    end
  end

  context 'without videos' do
    let(:videos) { [] }

    it "doesn't display videos" do
      view.should_receive(:videos).once.and_return(videos)
      render
      rendered.should have_selector 'ul' do |ul|
        ul.should_not have_selector 'li'
      end
    end
  end
end
