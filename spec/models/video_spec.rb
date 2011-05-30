require 'spec_helper'

describe Video do
  it { should have_db_column(:original_video).of_type(:string) }
  it { should have_db_column(:processed_video).of_type(:string) }

  it 'mounts a VideoUploader for file' do
    Video.new.original_video.should be_instance_of(VideoUploader)
  end

  it 'mounts a VideoUploader for processed_file' do
    Video.new.processed_video.should be_instance_of(VideoUploader)
  end

  describe '#file_name' do
    it 'returns the name of the uploaded file' do
      video = Fabricate(:video)
      video.original_video.file.stub(:filename).and_return('rails.png')
      video.original_video.file.should_receive(:filename)
      video.file_name.should == 'rails.png'
    end
  end

  describe '#temp_file_path' do
    it 'returns the temp file path' do
      video = Fabricate(:video)
      video.temp_file_path.should == Rails.root.join('tmp', "video_#{video.id}.avi")
    end
  end

  describe '#process' do
    before(:each) do
      @video = Fabricate(:video)
      @video.stub(:system)
      FileUtils.cp(Rails.root.join('app', 'assets', 'images', 'rails.png'), @video.temp_file_path)
    end

    it 'calls the video processor' do
      @video.should_receive(:system).with(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
        @video.original_video.file.path, @video.temp_file_path)
      @video.process
    end

    it 'stores the processed file' do
      @video.processed_video.file.should be_nil
      @video.process
      @video.processed_video.file.filename.should == File.basename(@video.temp_file_path)
    end

    it 'deletes the temp file' do
      @video.process
      File.exists?(@video.temp_file_path).should be_false
    end
  end

  describe '#async_process' do
    it 'enqueues the video' do
      @video = Fabricate(:video)
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).with(ProcessVideo, @video.id)
      @video.async_process
    end
  end
end
