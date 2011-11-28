RAILS_ENV = ENV['RAILS_ENV'] || 'production'
RAILS_ROOT = ENV['RAILS_ROOT'] || '/home/ubuntu/optical-flow'
WEBRICK_PID_FILE = "#{RAILS_ROOT}/tmp/pids/server.pid"

God.watch do |w|
  w.name = 'optical-flow-webrick'
  w.start = "cd #{RAILS_ROOT}; rails server -e #{RAILS_ENV} -p 80 -d"
  w.stop = "kill -9 `cat #{WEBRICK_PID_FILE}`"
  w.restart = [w.start, w.stop].join('; ')
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = WEBRICK_PID_FILE

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.interval = 20.minutes
      c.above = 150.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end
  
    restart.condition(:cpu_usage) do |c|
      c.interval = 20.minutes
      c.above = 50.percent
      c.times = 5
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
