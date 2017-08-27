require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject {
    described_class.new(customer_id: 1)
  }

  it "belongs to customer" do
    transaction = described_class.reflect_on_association(:customer)
    expect(transaction.macro).to eq :belongs_to
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a customer" do
   subject.customer = nil
   expect(subject).to_not be_valid
  end

  it "price equals $5 for a car" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "car"
    )
    transaction = Transaction.create(customer: customer)
    expect(transaction.price).to eq 500
  end

  it "price equals $10 for a truck" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "truck"
    )
    transaction = Transaction.create(customer: customer)
    expect(transaction.price).to eq 1000
  end

  it "price includes $2 charge for a truck that has mud in the bed" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "truck"
    )
    transaction = Transaction.create(
      customer: customer,
      mud: true
    )
    expect(transaction.price).to eq 1200
  end

  it "does not include a valid confirmation code if customer has a truck with the bed let down" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "truck"
    )
    transaction = Transaction.create(
      customer: customer,
      bed_down: true
    )
    transaction.save!
    expect(transaction.confirmation).to eq nil
  end

  it "includes 50% discount for second visit" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "car"
    )
    first_transaction = Transaction.create(customer: customer)
    second_transaction = Transaction.create(customer: customer)
    expect(second_transaction.price).to eq 250
  end

  it "does not include a valid confirmation code if license plate is '1111111'" do
    customer = Customer.create(
      license: "1111111",
      vehicle_type:  "car"
    )
    transaction = Transaction.create(customer: customer)
    expect(transaction.confirmation).to eq nil
  end

  it "is valid is car has a bed let down" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "car"
    )
    transaction = Transaction.create(
      customer: customer,
      bed_down: true
    )
    expect(transaction.confirmation).not_to eq nil
  end

  it "price still equal $5 if car has mud in the bed" do
    customer = Customer.create(
      license: "123456",
      vehicle_type:  "car"
    )
    transaction = Transaction.create(
      customer: customer,
      mud: true
    )
    expect(transaction.price).to eq 500
  end
end
