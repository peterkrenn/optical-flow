require 'spec_helper'

describe 'videos/index.html.haml' do
  context 'with videos' do
    let(:videos) { [stub_model(Video, :original_filename => 'video.mov')] * 2 }

    before(:each) { view.should_receive(:videos).once.and_return(videos) }

    it 'displays all videos' do
      render
      rendered.should have_selector '#video_list ul' do |ul|
        ul.should have_selector 'li', :content => 'video.mov', :count => 2
      end
    end

    it 'displays process links for all videos' do
      render
      videos.each do |video|
        rendered.should have_selector 'a', :href => "/videos/#{video.id}", :'data-method' => 'put'
      end
    end
  end

  context 'without videos' do
    let(:videos) { [] }

    it "doesn't display videos" do
      view.should_receive(:videos).once.and_return(videos)
      render
      rendered.should have_selector '#video_list ul' do |ul|
        ul.should_not have_selector 'li'
      end
    end
  end
end
