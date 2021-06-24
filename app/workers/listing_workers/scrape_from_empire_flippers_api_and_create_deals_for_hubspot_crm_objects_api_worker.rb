module ListingWorkers
  class ScrapeFromEmpireFlippersApiAndCreateDealsForHubspotCrmObjectsApiWorker
    include Sidekiq::Worker

    def perform(*args)
      Listings::ScrapeFromEmpireFlippersApi.new.run
      Listings::CreateDealsForHubspotCrmObjectsApi.new.run
    end
  end
end
