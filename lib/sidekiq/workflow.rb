require "sidekiq"
require "redis-namespace"
require "dm-core"
require "dm-types"
require "dm-redis-adapter"
require "sidekiq/workflow/version"
require "sidekiq/workflow/client_middleware"
require "sidekiq/workflow/server_middleware"
require "sidekiq/workflow/manager"
require "sidekiq/workflow/node"

class TestWorker
  include Sidekiq::Worker

  def perform
    sleep(5)
  end
end

DataMapper.setup(:default, {:adapter  => "redis"})

module Sidekiq::Workflow

  def self.run(workflow_definition)
    workflow = Workflow.create(workflow_definition)

    Manager.execute workflow
    workflow.id
  end

  class Workflow
    include DataMapper::Resource

    property :id, Serial
    property :workflow_definition, Json
    property :nodes, Json

    def initialize(workflow_definition)
      raise ArgumentError.new('workflow_definition can\'t be nil') unless workflow_definition
      self.workflow_definition = workflow_definition
      self.nodes = parsed_definition
      binding.pry
    end

    def parsed_definition
      @parsed_definition ||= Manager.parse workflow_definition
    end
  end
end
