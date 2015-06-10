class Sidekiq::Workflow::ClientMiddleware
  def call(worker_class, msg, queue, redis_pool)
    puts "Sidekiq::Workflow::ClientMiddleware called with:\n  worker_class: #{worker_class}\n  msg: #{msg}\n  queue: #{queue}\n  redis_pool: #{redis_pool}"
    yield
  end
end
