require 'spec_helper'

describe Video do
  it { should have_db_column(:original_filename).of_type(:string) }
  it { should have_db_column(:original_video).of_type(:string) }
  it { should have_db_column(:processed_video).of_type(:string) }
  it { should have_db_column(:state).of_type(:string) }
  it { should have_db_column(:enqueued_at).of_type(:datetime) }
  it { should have_db_column(:processing_started_at).of_type(:datetime) }
  it { should have_db_column(:processing_finished_at).of_type(:datetime) }

  it 'should be unprocessed initially' do
    Video.new.state.should == 'unprocessed'
  end

  it 'mounts a VideoUploader for file' do
    Video.new.original_video.should be_instance_of(VideoUploader)
  end

  it 'mounts a VideoUploader for processed_file' do
    Video.new.processed_video.should be_instance_of(VideoUploader)
  end

  describe '#enqueue' do
    before(:each) do
      @video = Fabricate(:video)
      @video.stub(:async_process)
    end

    it 'changes the state to enqeueued' do
      @video.state.should == 'unprocessed'
      @video.enqueue
      @video.state.should == 'enqueued'
    end

    it 'sets enqueued_at' do
      @video.enqueued_at.should be_nil
      @video.enqueue
      @video.enqueued_at.should_not be_nil
    end
  end

  describe '#start_processing' do
    before(:each) do
      @video = Fabricate(:video)
      @video.state = 'enqueued'
      @video.stub(:process)
    end

    it 'changes the state to processing' do
      @video.state.should == 'enqueued'
      @video.start_processing
      @video.state.should == 'processing'
    end

    it 'sets processing_started_at' do
      @video.processing_started_at.should be_nil
      @video.start_processing
      @video.processing_started_at.should_not be_nil
    end
  end

  describe '#finish_processing' do
    before(:each) do
      @video = Fabricate(:video)
      @video.state = 'processing'
    end

    it 'changes the state to processed' do
      @video.state.should == 'processing'
      @video.finish_processing
      @video.state.should == 'processed'
    end

    it 'sets processing_finished_at' do
      @video.processing_finished_at.should be_nil
      @video.finish_processing
      @video.processing_finished_at.should_not be_nil
    end
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

    it 'calls #start_processing' do
      @video.should_receive(:start_processing)
      @video.process
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

    it 'calls #finish_processing' do
      @video.should_receive(:finish_processing)
      @video.process
    end
  end

  describe '#async_process' do
    before(:each) do
      @video = Fabricate(:video)
      Resque.stub(:enqueue)
    end

    it 'calls #enqueue' do
      @video.should_receive(:enqueue)
      @video.async_process
    end

    it 'enqueues the video' do
      Resque.should_receive(:enqueue).with(ProcessVideo, @video.id)
      @video.async_process
    end
  end
end
