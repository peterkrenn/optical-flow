require 'spec_helper'

describe 'videos/new.html.haml' do
  let(:video) { stub_model(Video, :original_video => 'original_video').as_new_record }

  it 'renders new video form' do
    view.should_receive(:video).once.and_return(video)
    render

    rendered.should have_selector('form',
      :action => videos_path, :method => 'post', :enctype => 'multipart/form-data') do |form|
        form.should have_selector('label', :for => 'video_original_video')
        form.should have_selector('input#video_original_video', :name => 'video[original_video]',
          :type => 'file')
        form.should have_selector('input#video_original_video_cache',
          :name => 'video[original_video_cache]', :type => 'hidden')
        form.should have_selector('input', :name => 'commit', :type => 'submit')
    end
  end
end
