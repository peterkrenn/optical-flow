class Video < ActiveRecord::Base
  mount_uploader :original_video, VideoUploader
  mount_uploader :processed_video, VideoUploader

  def file_name
    original_video.file.filename
  end

  def process
    system(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
      original_video.file.path, temp_file_path.to_s)
    update_attribute :processed_video, File.open(temp_file_path)
    FileUtils.rm(temp_file_path)
  end

  def async_process
    Resque.enqueue(ProcessVideo, self.id)
  end

  def temp_file_path
    Rails.root.join('tmp', "video_#{id}.avi")
  end
end
