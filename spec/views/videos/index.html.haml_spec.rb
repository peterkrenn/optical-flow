require 'spec_helper'

describe 'videos/index.html.haml' do
  context 'with videos' do
    let(:videos) { [Fabricate(:video), Fabricate(:enqueued_video), Fabricate(:processing_video), Fabricate(:processed_video)] }

    before(:each) { view.should_receive(:videos).once.and_return(videos) }

    it 'displays all videos' do
      render
      rendered.should have_selector '#video_list ul' do |ul|
        ul.should have_selector 'li', :count => 4
      end
    end

    it 'displays the original filename for all videos' do
      render
      rendered.should have_selector 'p', :content => 'rails.png', :count => 4
    end

    it 'displays a process link for unprocessed videos' do
      render
      videos.each do |video|
        if video.unprocessed?
          rendered.should have_selector 'p' do |p|
            p.should have_selector 'a', :href => "/videos/#{video.id}", :'data-method' => 'put'
          end
        else
          rendered.should_not have_selector 'a', :href => "/videos/#{video.id}", :'data-method' => 'put'
        end
      end
    end

    it 'displays download link for the original video for all videos' do
      render
      videos.each do |video|
        rendered.should have_selector 'p' do |p|
          p.should have_selector 'a', :href => video.original_video.url, :target => '_blank', :content => 'download original file'
        end
      end
    end

    it 'displays the time spent in queue for enqueued videos' do
      render
      videos.each do |video|
        if video.enqueued?
          rendered.should have_selector 'p', :content => "enqueued for #{time_ago_in_words(video.enqueued_at)}"
        end
      end
    end

    it 'displays the time spent processing for processing videos' do
      render
      videos.each do |video|
        if video.processing?
          rendered.should have_selector 'p', :content => "processing since #{time_ago_in_words(video.processing_started_at)}"
        end
      end
    end

    it 'displays the processing time for processed videos' do
      render
      videos.each do |video|
        if video.processed?
          rendered.should have_selector :p, :content => "processed in #{distance_of_time_in_words(video.processing_finished_at, video.processing_started_at)}"
        end
      end
    end

    it 'displays download link for the processed video for processed videos' do
      render
      videos.each do |video|
        if video.processed?
          rendered.should have_selector 'p' do |p|
            p.should have_selector 'a', :href => video.processed_video.url, :target => '_blank', :content => 'download processed file'
          end
        end
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
