module Listings
  # Scrapes Listing data from Empire Flippers API. Intended to be ran once a day.
  class ScrapeFromEmpireFlippersApi
    # max 'limit' is 100, see: https://empireflippers.com/empire-flippers-public-listings-api/
    def initialize(limit: nil, created_at_to: Time.current)
      @limit = limit
      @created_at_to = created_at_to
    end

    def run
      now = Time.current
      each_response do |response|
        listings = response[:data][:listings]
        insert_args = listings.map do |listing|
          insert_arg = convert_to_insert_arg(listing)
          insert_arg.merge(created_at: now, updated_at: now)
        end
        Listing.insert_all(insert_args) unless insert_args.empty?
      end

      { data: {} }
    end

    private

    # loops through pages 1..n of 'domain/url?page={page}'
    def each_response
      curr_page = default_last_page = 1
      last_page = nil
      created_at_from = optimized_created_at_from || default_created_at_from

      loop do
        params = {
          page: curr_page,
          created_at_from: created_at_from,
          created_at_to: @created_at_to,
        }
        params[:limit] = @limit if @limit
        response = get_response(params)
        last_page ||= response[:data][:pages] || default_last_page
        sleep_duration = EmpireFlippersApi.calc_rate_limit_sleep_duration { yield response }
        break if curr_page >= last_page
        sleep(sleep_duration) if sleep_duration.positive?
        curr_page += 1
      end
    end

    def get_response(**params)
      EmpireFlippersApi::Listing.list(**params)
    end

    def convert_to_insert_arg(listing)
      converted = listing.slice(:id, :listing_status, :listing_number, :listing_price, :summary)
      converted[:a__created_at] = listing[:created_at]
      converted
    end

    def optimized_created_at_from
      Listing.maximum(:a__created_at)
    end

    # In order to prevent long execution time when "listings" table is still empty,
    # (which is probably during first-time ever execution of this operation),
    # I set "created_at_from" to "30 days ago" as the default for the api query.
    def default_created_at_from
      @created_at_to - 30.days
    end
  end
end
