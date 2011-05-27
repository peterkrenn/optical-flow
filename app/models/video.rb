class Video < ActiveRecord::Base
  mount_uploader :file, VideoUploader

  def file_name
    file.file.filename
  end

  def process
    system(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s, file_name)
  end
end
