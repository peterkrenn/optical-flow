require 'spec_helper'

describe Video do
  it { should have_db_column(:file).of_type(:string) }
  it { should have_db_column(:processed_file).of_type(:string) }

  it 'mounts a VideoUploader for file' do
    Video.new.file.should be_instance_of(VideoUploader)
  end

  it 'mounts a VideoUploader for processed_file' do
    Video.new.processed_file.should be_instance_of(VideoUploader)
  end

  describe '#file_name' do
    it 'returns the name of the uploaded file' do
      video = Fabricate(:video)
      video.file.file.stub(:filename).and_return('rails.png')
      video.file.file.should_receive(:filename)
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
        @video.file.file.path, @video.temp_file_path)
      @video.process
    end

    it 'stores the processed file' do
      @video.processed_file.file.should be_nil
      @video.process
      @video.processed_file.file.filename.should == File.basename(@video.temp_file_path)
    end

    it 'deletes the temp file' do
      @video.process
      File.exists?(@video.temp_file_path).should be_false
    end
  end
end
