require 'rails_helper'

RSpec.describe Listings::CreateDealsForHubspotCrmObjectsApi, :vcr do
  # 'closedate' should remain constant, since it is dependency in 'spec/cassettes'
  let(:closedate) { Time.zone.parse('2038-01-01T00:00:00.000Z') }

  describe '#run' do
    context 'listing is "For Sale", not in Hubspot' do
      it 'creates Hubspot Deal' do
        operation = Listings::CreateDealsForHubspotCrmObjectsApi.new(closedate: closedate)
        listing = Listing.create(
          listing_status: 'For Sale',
          x__is_in_hubspot: false,
          listing_number: 1,
          listing_price: 1.to_d,
          summary: '1',
        )
        expect { operation.run }.to change { listing.reload.x__is_in_hubspot }.from(false).to(true)
      end
    end

    context 'listing is "For Sale", is in Hubspot' do
      it 'does not create a Hubspot Deal' do
        operation = Listings::CreateDealsForHubspotCrmObjectsApi.new(closedate: closedate)
        listing = Listing.create(
          listing_status: 'For Sale',
          x__is_in_hubspot: true,
          listing_number: 2,
          listing_price: 2.to_d,
          summary: '2',
        )
        expect { operation.run }.to_not change { listing.reload.x__is_in_hubspot }
      end
    end
  end
end
