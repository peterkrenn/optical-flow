Fabricator(:video) do
  original_video { File.open(File.join(Rails.root, 'app', 'assets', 'images', 'rails.png')) }
end
