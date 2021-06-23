require 'rails_helper'

RSpec.describe Listing, type: :model do
  subject { Listing.new }

  it { is_expected.to be_valid }
end
