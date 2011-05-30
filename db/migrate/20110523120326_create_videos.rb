class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |table|
      table.string :original_video
      table.string :processed_video

      table.timestamps
    end
  end
end
