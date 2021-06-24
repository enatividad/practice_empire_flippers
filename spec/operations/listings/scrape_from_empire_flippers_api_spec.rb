require 'rails_helper'

RSpec.describe Listings::ScrapeFromEmpireFlippersApi, :vcr do
  # 'created_at_to' should remain constant, since it is dependency in 'spec/cassettes'
  let(:created_at_to) { Time.zone.parse('2021-06-23T00:00:00.000Z') }

  describe '#run' do
    it 'adds Listing records after running' do
      operation = Listings::ScrapeFromEmpireFlippersApi.new(created_at_to: created_at_to)
      expect { operation.run }.to change { Listing.count }.by_at_least(1)
    end
  end
end
