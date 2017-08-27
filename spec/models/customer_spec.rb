require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject {
    described_class.new(
      vehicle_type: 'car',
      license: '12345678'
    )
  }

  it "has many transactions" do
    customer = described_class.reflect_on_association(:transactions)
    expect(customer.macro).to eq :has_many
  end

  it "is valid with valid attributes (car)" do
    expect(subject).to be_valid
  end

  it "is valid with valid attributes (truck)" do
   subject.vehicle_type = 'truck'
   expect(subject).to be_valid
  end

  it "is not valid without a vehicle type" do
   subject.vehicle_type = nil
   expect(subject).to_not be_valid
  end

  it "is not valid with an invalid vehicle type (suburban)" do
   subject.vehicle_type = 'suburban'
   expect(subject).to_not be_valid
  end
end
