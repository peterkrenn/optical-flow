class Video < ActiveRecord::Base
  mount_uploader :original_video, VideoUploader
  mount_uploader :processed_video, VideoUploader

  state_machine :initial => :unprocessed do
    event :enqueue do
      transition :unprocessed => :enqueued
    end

    event :start_processing do
      transition [:unprocessed, :enqueued] => :processing
    end

    event :finish_processing do
      transition :processing => :processed
    end

    before_transition :unprocessed => :enqueued do |video|
      video.update_attribute :enqueued_at, Time.now
    end

    before_transition :enqueued => :processing do |video|
      video.update_attribute :processing_started_at, Time.now
    end

    before_transition :processing => :processed do |video|
      video.update_attribute :processing_finished_at, Time.now
    end
  end

  def process
    start_processing
    original_video.cache_stored_file!
    system(Rails.root.join('vendor', 'lucas-kanade-opencv').to_s,
      original_video_cached_file_path.to_s, temp_file_path.to_s)
    update_attribute :processed_video, File.open(temp_file_path)
    FileUtils.rm(temp_file_path)
    finish_processing
  end

  def async_process
    enqueue
    Resque.enqueue(ProcessVideo, self.id)
  end

  def original_video_cached_file_path
    Rails.root.join(original_video.cache_dir, original_video.cache_name)
  end

  def temp_file_path
    Rails.root.join('tmp', "video_#{id}.avi")
  end
end
