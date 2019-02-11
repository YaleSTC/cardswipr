# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'is invalid with nil title' do
    event = Event.new(title: nil, description: 'Sample description')
    expect(event).to be_invalid
  end

  it 'is invalid with a blank title' do
    event = Event.new(title: '    ', description: 'Sample description')
    expect(event).to be_invalid
  end

  it 'is invalid with a long title' do
    title = 'a' * 51
    event = Event.new(title: title, description: 'Sample description')
    expect(event).to be_invalid
  end

  it 'removes leading and trailing whitespace from title' do
    event = Event.new(title: '  Sample Title   ',
                      description: ' Sample description  ')
    event.valid?
    expect(event.title).to eq(event.title.strip)
  end

  it 'removes leading and trailing whitespace from description' do
    event = Event.new(title: '  Sample Title   ',
                      description: ' Sample description  ')
    event.valid?
    expect(event.description).to eq(event.description.strip)
  end

  it 'is valid with nil description' do
    event = Event.new(title: 'Sample Title', description: nil)
    expect(event).to be_valid
  end

  it 'is valid with a blank description' do
    event = Event.new(title: 'Sample Title', description: '          ')
    expect(event).to be_valid
  end

  it 'is valid with nonempty title and description' do
    event = Event.new(title: 'Sample Title', description: 'Sample description')
    expect(event).to be_valid
  end
end
