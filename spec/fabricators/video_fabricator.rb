Fabricator(:video) do
  original_video { File.open(Rails.root.join('app', 'assets', 'images', 'rails.png')) }
  original_filename 'rails.png'
end
