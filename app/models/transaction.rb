class Transaction < ActiveRecord::Base
  require 'securerandom'
  belongs_to :customer
  validates :customer_id, :presence => true
  before_create :transaction_options

  def transaction_options
    if self.customer.vehicle_type == 'car'
      self.bed_down = 0
      self.mud = 0
    end
    self.discount = self.get_discount
    unless $stolen_plates.include?(self.customer.license) || self.bed_down == true
      self.confirmation = SecureRandom.hex(4).upcase + '-' +  SecureRandom.hex(4).upcase
    end
    self.price = self.calculate_price
  end

  def get_discount
    visit = Transaction.where(customer_id: self.customer.id, bed_down: 0).count
    (visit%2 == 1) ? 0.5 : 0
  end

  def calculate_price
    if self.confirmation.nil?
      0
    else
      base_price = self.customer.vehicle_type == 'truck' ? 1000 : 500
      mud_fee = self.mud == true ? 200 : 0
      visit_discount = 1 - self.discount
      (base_price + mud_fee)*visit_discount
    end
  end

end
