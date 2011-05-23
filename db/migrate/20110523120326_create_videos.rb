class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :file

      t.timestamps
    end
  end
end
