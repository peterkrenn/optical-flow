class AddOriginalFilenameToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :original_filename, :string
  end
end
