if Customer.count == 0
  customers = [
    {license: 'ABC1234',  vehicle_type: 'car'},
    {license: 'DEF123',   vehicle_type: 'car'},
    {license: 'ABC4321',  vehicle_type: 'truck'},
    {license: 'DEF4321',  vehicle_type: 'truck'},
    {license: 'GHIJ4321', vehicle_type: 'truck'},
    {license: '1111111',  vehicle_type: 'truck'}
  ]
  customers.each do |c|
    customer = Customer.new
    customer.license = c[:license]
    customer.vehicle_type = c[:vehicle_type]
    customer.save
  end
end

if Transaction.count == 0
  Customer.all.each do |customer|
    transaction = Transaction.new
    transaction.customer_id = customer.id
    transaction.mud = false
    transaction.bed_down = false
    transaction.price = Transaction.calculate_price(customer)
    transaction.save
  end

  car_customer = Customer.where(vehicle_type: 'car').first
  truck_customer = Customer.where(vehicle_type: 'truck').first

  options = [
    {customer: car_customer,   mud: 1, bed_down: 1},
    {customer: car_customer,   mud: 1, bed_down: 0},
    {customer: car_customer,   mud: 0, bed_down: 1},
    {customer: car_customer,   mud: 0, bed_down: 0},
    {customer: truck_customer, mud: 1, bed_down: 1},
    {customer: truck_customer, mud: 1, bed_down: 0},
    {customer: truck_customer, mud: 0, bed_down: 1},
    {customer: truck_customer, mud: 0, bed_down: 0}
  ]

  options.each do |opt|
    transaction = Transaction.new
    transaction.customer = opt[:customer]
    transaction.mud = opt[:mud]
    transaction.bed_down = opt[:bed_down]
    transaction.price = Transaction.calculate_price(opt[:customer], opt[:mud], opt[:bed_down])
    transaction.save
  end

end
