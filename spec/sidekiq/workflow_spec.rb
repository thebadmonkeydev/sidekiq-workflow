require 'spec_helper'

describe Sidekiq::Workflow do
  it 'has a version number' do
    expect(Sidekiq::Workflow::VERSION).not_to be nil
  end
end
