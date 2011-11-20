class AddStateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :state, :string
    add_column :videos, :enqueued_at, :datetime
    add_column :videos, :processing_started_at, :datetime
    add_column :videos, :processing_finished_at, :datetime
  end
end
