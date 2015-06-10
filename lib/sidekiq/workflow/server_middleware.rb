class Sidekiq::Workflow::ServerMiddleware
  def call(worker_class, msg, queue)
    puts "Sidekiq::Workflow::ServerMiddleware called with:\n  worker_class: #{worker_class}\n  msg: #{msg}\n  queue: #{queue}"
    yield
  end
end
