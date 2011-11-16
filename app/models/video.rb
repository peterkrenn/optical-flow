class Video < ActiveRecord::Base
  mount_uploader :original_video, VideoUploader
  mount_uploader :processed_video, VideoUploader

  before_create :set_original_filename

  def set_original_filename
    original_filename = original_video.file.original_filename
  end

  def process
    original_video.cache_stored_file!
    system(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
      original_video_cached_file_path.to_s, temp_file_path.to_s)
    update_attribute :processed_video, File.open(temp_file_path)
    FileUtils.rm(temp_file_path)
  end

  def async_process
    Resque.enqueue(ProcessVideo, self.id)
  end

  def original_video_cached_file_path
    Rails.root.join(original_video.cache_dir, original_video.cache_name)
  end

  def temp_file_path
    Rails.root.join('tmp', "video_#{id}.avi")
  end
end
