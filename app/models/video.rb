class Video < ActiveRecord::Base
  mount_uploader :file, VideoUploader
end
