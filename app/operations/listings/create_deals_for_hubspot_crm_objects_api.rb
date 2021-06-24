module Listings
  # Uses recent Listing data to Create Hubspot CRM Deals that has (by default) a
  # 'closedate' which is 30 days from now. Intended to be ran once a day.
  class CreateDealsForHubspotCrmObjectsApi
    def initialize(closedate: 30.days.from_now)
      @closedate = closedate
    end

    def run
      # Retrieve in batches 'of: 100', since Hubspot only accepts 100 records at
      # a time.
      Listing
        .select(:listing_number, :listing_price, :summary)
        .where(listing_status: 'For Sale', x__is_in_hubspot: false)
        .in_batches(of: 100) do |listings_batch|
          create_deals listings_batch
        end

      { data: {} }
    end

    private

    def create_deals(listings)
      # build 'inputs' param
      inputs = []
      listings.each do |listing|
        inputs << {
          properties: {
            dealname: "Listing #{listing.listing_number}",
            amount: listing.listing_price.to_d,
            closedate: @closedate,
            description: listing.summary,
          },
        }
      end

      # create the deals
      response = HubspotCrmObjectsApi::Deal.batch_create(inputs: inputs)

      # and mark records as "already created in Hubspot"
      listings.update_all x__is_in_hubspot: true

      response
    end
  end
end
