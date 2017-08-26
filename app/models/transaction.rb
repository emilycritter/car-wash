class Transaction < ActiveRecord::Base
  belongs_to :customer
  before_create :validates_vehicle_options

  def validates_vehicle_options
    if self.customer.vehicle_type == 'car'
      self.bed_down = 0
      self.mud = 0
    end
  end

  def self.calculate_price (customer, mud=0, bed_down=0)
    visit = Transaction.where(customer_id: customer.id, bed_down: 0).count
    if customer.license == '1111111' || bed_down == 1 && customer.vehicle_type == 'truck'
      0
    else
      base_price = customer.vehicle_type == 'truck' ? 1000 : 500
      mud_fee = (mud == 1 && customer.vehicle_type == 'truck') ? 200 : 0
      visit_discount = (visit%2 == 1) ? 0.5 : 1
      (base_price + mud_fee)*visit_discount
    end
  end
end
