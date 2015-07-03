class Sidekiq::Workflow::Node
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String

  property :params, Json
  property :completed_ids, Json
  property :queued_ids, Json

end

DataMapper.finalize
