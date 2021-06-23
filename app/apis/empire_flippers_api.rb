# Please refer to: https://empireflippers.com/empire-flippers-public-listings-api/
module EmpireFlippersApi
  BASE_URL = 'https://api.empireflippers.com/api/v1/'

  module Listing
    def self.list(**params)
      response = Faraday.get(BASE_URL + 'listings/list', params)

      raise 'The http request did not return a "success" status' unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
