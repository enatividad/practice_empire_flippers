# Please refer to: https://empireflippers.com/empire-flippers-public-listings-api/
module EmpireFlippersApi
  BASE_URL = 'https://api.empireflippers.com/api/v1/'

  def self.rate_limit
    # 0.0 because using mocks to speed up testing
    return 0.0 if Rails.env.test?

    # as stated in: https://empireflippers.com/empire-flippers-public-listings-api/
    # "Please make no more than 1 request per second."
    1.0
  end

  def self.calc_rate_limit_sleep_duration
    past = Time.now
    yield
    request_duration = Time.now - past
    sleep_duration = rate_limit - request_duration
    [0.0, sleep_duration].max
  end

  module Listing
    def self.list(**params)
      response = Faraday.get(BASE_URL + 'listings/list', params)

      raise 'The http request did not return a "success" status' unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
