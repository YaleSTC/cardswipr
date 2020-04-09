# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe PreregistrationImporter do
  let(:event) { create(:event, preregistration: true) }
  let(:pathname) do
    Rails.root.join('spec', 'fixtures', 'prereg_import', 'search_params.csv')
  end
  let(:importer) { described_class.new(event: event, path: pathname) }

  context 'with successful creation' do
    before do
      creator = instance_double(PreregistrationCreator)
      allow(PreregistrationCreator).to receive(:new).and_return(creator)
      allow(creator).to receive(:call).and_return(true)
    end

    it 'counts one preregistration for each search param' do
      count = pathname.each_line.count - 1 # don't count the header line
      importer.call
      expect(importer.count).to eq(count)
    end

    it 'calls the creator with the correct event and search params' do
      importer.call
      CSV.foreach(pathname, headers: true) do |row|
        expect(PreregistrationCreator).to\
          have_received(:new).with(event: event, search_param: row[0])
      end
    end
  end

  context 'with unsuccessful creation' do
    before do
      creator = instance_double(PreregistrationCreator)
      allow(PreregistrationCreator).to receive(:new).and_return(creator)
      allow(creator).to receive(:call).and_return(false)
    end

    it 'fails to count search params' do
      importer.call
      expect(importer.count).to eq(0)
    end
  end
end
