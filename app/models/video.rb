class Video < ActiveRecord::Base
  mount_uploader :file, VideoUploader

  def file_name
    file.file.filename
  end
end
