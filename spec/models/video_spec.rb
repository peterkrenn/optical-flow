require 'spec_helper'

describe Video do
  it { should have_db_column(:file).of_type(:string) }

  it 'should mount a VideoUploader' do
    Video.new.file.should be_instance_of(VideoUploader)
  end
end
