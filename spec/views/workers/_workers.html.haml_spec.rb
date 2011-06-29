require 'spec_helper'

describe 'workers/_workers.html.haml' do
  context 'with workers' do
    it 'displays all workers' do
      worker = double(Resque::Worker)
      worker.should_receive(:hostname).twice.and_return('hostname')
      worker.should_receive(:pid).twice.and_return(1234)
      worker.should_receive(:state).twice.and_return(:idle)
      workers = [worker] * 2
      view.should_receive(:workers).and_return(workers)

      render
      rendered.should have_selector 'ul' do |ul|
        ul.should have_selector 'li', :count => 2
      end
    end
  end

  context 'without workers' do
    it "doesn't display workers" do
      view.should_receive(:workers).and_return([])

      render
      rendered.should have_selector 'ul' do |ul|
        ul.should_not have_selector 'li'
      end
    end
  end
end
