Fabricator(:video) do
  file { File.open(File.join(Rails.root, 'app', 'assets', 'images', 'rails.png')) }
end
