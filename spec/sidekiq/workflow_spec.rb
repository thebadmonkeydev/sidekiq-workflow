require 'spec_helper'

describe Sidekiq::Workflow do
  it 'has a version number' do
    expect(Sidekiq::Workflow::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
