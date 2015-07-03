module Sidekiq
  module Workflow

    class ServerMiddleware
      def call(worker_class, msg, queue)
        puts "Sidekiq::Workflow::ServerMiddleware called with:\n  worker_class: #{worker_class}\n  msg: #{msg}\n  queue: #{queue}"

        yield
        # find wid, find nid within the workflow, then move jid from queued_ids to completed_ids
        if msg['sw_wid'] && msg['sw_nid']
          workflow = Sidekiq::Workflow::Workflow.get(msg['sw_wid'])
          nodes = workflow.nodes.map { |n| Node.get(n) }

          workflow.nodes.shift
          if workflow.save
            Manager.execute(workflow) unless workflow.nodes.empty?
          end
        end
      end
    end
  end
end

