require 'spec_helper'

describe Video do
  it { should have_db_column(:file).of_type(:string) }

  it 'mounts a VideoUploader' do
    Video.new.file.should be_instance_of(VideoUploader)
  end

  describe '#file_name' do
    it 'returns the name of the uploaded file' do
      video = Fabricate(:video)
      video.file.file.stub(:filename).and_return('rails.png')
      video.file.file.should_receive(:filename)
      video.file_name.should == 'rails.png'
    end
  end

  describe '#process' do
    it 'calls video processor' do
      video = Fabricate(:video)
      video.stub(:system)
      video.should_receive(:system).with(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
        video.file_name)
      video.process
    end
  end
end
