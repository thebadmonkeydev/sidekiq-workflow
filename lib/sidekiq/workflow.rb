require "sidekiq"
require "sidekiq/workflow/version"
require "sidekiq/workflow/client_middleware"
require "sidekiq/workflow/server_middleware"

module Sidekiq
  module Workflow
    def self.run(workflow_definition)
      #WorkflowValidator.validate workflow_definition
      #WorkflowManager.execute workflow_definition
    end
  end
end
