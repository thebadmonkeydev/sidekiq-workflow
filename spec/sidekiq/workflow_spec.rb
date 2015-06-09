require 'spec_helper'

describe Sidekiq::Workflow do
  it 'has a version number' do
    expect(Sidekiq::Workflow::VERSION).not_to be nil
  end

  describe 'API' do
    it 'has a run method' do
      expect(Sidekiq::Workflow).to respond_to :run
    end
  end
end
