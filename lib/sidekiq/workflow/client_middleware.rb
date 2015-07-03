class Sidekiq::Workflow::ClientMiddleware
  attr_accessor :wid, :nid

  def call(worker_class, msg, queue, redis_pool)
    puts "BEFORE:= Sidekiq::Workflow::ClientMiddleware called with:\n  worker_class: #{worker_class}\n  msg: #{msg}\n  queue: #{queue}\n  redis_pool: #{redis_pool}"
    if is_sw_job? msg['args']
      parse(msg['args']).tap do |params|
        msg['sw_wid'] = params[1]
        msg['sw_nid'] = params[2]
      end
    end
    puts "AFTER:= Sidekiq::Workflow::ClientMiddleware called with:\n  worker_class: #{worker_class}\n  msg: #{msg}\n  queue: #{queue}\n  redis_pool: #{redis_pool}"
    yield
  end

  protected

  def is_sw_job?(args)
    args.is_a?(Array) &&
      args.last.is_a?(Array) &&
      args.last.include?('sidekiq-workflow')
  end

  def parse(args)
    # This also strips the sidekiq-workflow params from msg['args']
    @args ||= args.pop
  end

  def set_queued_ids(jid)
    Workflow.find(wid)
  end
end
