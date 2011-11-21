Fabricator(:video) do
  original_video File.open(Rails.root.join('app', 'assets', 'images', 'rails.png'))
  original_filename 'rails.png'
end

Fabricator(:enqueued_video, :from => :video) do
  state 'enqueued'
  enqueued_at Time.now
end

Fabricator(:processing_video, :from => :enqueued_video) do
  state 'processing'
  processing_started_at Time.now
end

Fabricator(:processed_video, :from => :processing_video) do
  processed_video File.open(Rails.root.join('app', 'assets', 'images', 'rails.png'))
  state 'processed'
  processing_finished_at Time.new
end
