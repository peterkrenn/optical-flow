class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |table|
      table.string :file
      table.string :processed_file

      table.timestamps
    end
  end
end
