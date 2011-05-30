class ProcessVideo
  @queue = :optical_flow

  def self.perform(id)
    Video.find(id).process
  end
end
