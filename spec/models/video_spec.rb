require 'spec_helper'

describe Video do
  it { should have_db_column(:file).of_type(:string) }

  it 'mounts a VideoUploader' do
    Video.new.file.should be_instance_of(VideoUploader)
  end

  describe '#file_name' do
    it 'returns the name of the uploaded file' do
      video = Video.new
      file = double(CarrierWave::SanitizedFile, :filename => 'video.mov')
      video.stub(:file) { double(VideoUploader, :file => file) }
      file.should_receive(:filename)
      video.file_name.should == 'video.mov'
    end
  end
end
