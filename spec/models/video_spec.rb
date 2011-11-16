require 'spec_helper'

describe Video do
  it { should have_db_column(:original_filename).of_type(:string) }
  it { should have_db_column(:original_video).of_type(:string) }
  it { should have_db_column(:processed_video).of_type(:string) }

  it 'mounts a VideoUploader for file' do
    Video.new.original_video.should be_instance_of(VideoUploader)
  end

  it 'mounts a VideoUploader for processed_file' do
    Video.new.processed_video.should be_instance_of(VideoUploader)
  end

  describe '#original_video_cached_file_path' do
    it 'returns the path of the cached file' do
      video = Fabricate(:video)
      video.original_video.stub(:cache_name).and_return('cache_name')
      video.original_video_cached_file_path.should ==
        Rails.root.join(video.original_video.cache_dir, video.original_video.cache_name)
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
      @video.original_video.stub(:cache_stored_file!)
      @video.original_video.stub(:cache_name).and_return('cache_name')

      # Use rails logo as dummy for video file
      FileUtils.cp(Rails.root.join('app', 'assets', 'images', 'rails.png'), @video.temp_file_path)
    end

    it 'caches the video file' do
      @video.original_video.should_receive(:cache_stored_file!)
      @video.process
    end

    it 'calls the video processor' do
      @video.should_receive(:system).with(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
        @video.original_video_cached_file_path.to_s, @video.temp_file_path.to_s)
      @video.process
    end

    it 'stores the processed file' do
      @video.processed_video.file.should be_nil
      @video.process
      @video.processed_video.file.should_not be_nil
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
