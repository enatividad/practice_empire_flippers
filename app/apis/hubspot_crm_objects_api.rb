module HubspotCrmObjectsApi
  BASE_URL = 'https://api.hubapi.com/crm/v3/objects/'
  HEADERS = { 'Content-Type' => 'application/json' }
  HAPIKEY = Rails.application.credentials.hubspot.fetch(:hapikey)

  def self.url(path)
    BASE_URL + path + '?hapikey=' + HAPIKEY
  end

  # see: https://developers.hubspot.com/docs/api/crm/deals
  module Deal
    def self.batch_create(**params)
      url = module_parent.url('deals/batch/create')
      response = Faraday.post(url, params.to_json, HEADERS)
      raise 'The http request did not return a "created" status' if response.status != 201
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
