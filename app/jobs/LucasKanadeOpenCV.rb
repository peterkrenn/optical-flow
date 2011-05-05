class LucasKanadeOpenCV
  @queue = :optical_flow

  def self.perform(file_name)
    Video.find(file_name).process
  end
end
