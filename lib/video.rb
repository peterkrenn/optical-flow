class Video
  attr_accessor :file_name, :path

  def initialize(path)
    @path = path
    @file_name = File.basename(@path)
  end

  def self.all
    Dir[Rails.root.join('public', 'uploads', '*')].map { |path| self.new(path) }
  end

  def self.find(file_name)
    path = Rails.root.join('public', 'uploads', file_name)

    if File.exists?(path)
      self.new(path)
    else
      nil
    end
  end

  def enqueue
    Resque.enqueue(LucasKanadeOpenCV, @file_name)
  end

  def process
    p 'processing...'
  end
end
