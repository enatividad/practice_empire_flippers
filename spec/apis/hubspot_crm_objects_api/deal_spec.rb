require 'rails_helper'

RSpec.describe HubspotCrmObjectsApi::Deal, :vcr do
  describe '#batch_create' do
    # 'closedate' should remain constant, since it is dependency in 'spec/cassettes'
    let(:closedate) { Time.zone.parse('2038-01-01T00:00:00.000Z') }

    it 'succeeds' do
      inputs =
        (3..5).map do |i|
          {
            properties: {
              dealname: "dealname: #{i}",
              amount: (1..i).reverse_each.map(&:to_s).join.to_d,
              closedate: closedate + i.day,
              description: "description: #{i}",
            },
          }
        end
      response = HubspotCrmObjectsApi::Deal.batch_create(inputs: inputs)
      expect(response).to be_a(Hash)
      expect(response[:results].length).to eql 3
    end
  end
end
