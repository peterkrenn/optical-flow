Fabricator(:video) do
  original_video do
    file = File.open(Rails.root.join('app', 'assets', 'images', 'rails.png'))
    ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
  end

  original_filename 'rails.png'
end
