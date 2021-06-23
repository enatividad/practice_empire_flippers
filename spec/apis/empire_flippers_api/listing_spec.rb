require 'rails_helper'

RSpec.describe EmpireFlippersApi::Listing, :vcr do
  describe '#list' do
    context 'no params' do
      subject { EmpireFlippersApi::Listing.list }

      it { is_expected.to be_a(Hash) }
    end
  end
end
