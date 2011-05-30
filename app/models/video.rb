class Video < ActiveRecord::Base
  mount_uploader :file, VideoUploader
  mount_uploader :processed_file, VideoUploader

  def file_name
    file.file.filename
  end

  def process
    system(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
      file.file.path, temp_file_path)
    update_attribute :processed_file, File.open(temp_file_path)
    FileUtils.rm(temp_file_path)
  end

  def temp_file_path
    Rails.root.join('tmp', "video_#{id}.avi")
  end
end
