class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @customer = Customer.new
  end

  def create
    @transaction = Transaction.new transaction_params
    vehicle_type = params[:transaction][:truck] == "on" ? "truck" : "car"
    license = params[:transaction][:license].html_safe
    @customer = Customer.find_or_create_by(
      license: license,
      vehicle_type: vehicle_type
    )
    if $stolen_plates.include?(license)
      flash[:alert] = "Calling 911! Vehicle reported stolen."
      render :new
    elsif @customer.id
      @transaction.customer_id = @customer.id
      flash[:alert] = "Sorry, we cannot offer you a car wash code at this time. Please ensure the bed of your truck is up and try again." if @transaction.bed_down == true
      redirect_to transaction_path(id: @transaction.id) if @transaction.save
    else
      @customer = Customer.find_by(license: license)
      if @customer && @customer.vehicle_type != vehicle_type
        flash[:warning] = "The license plate you entered is associated with a different vehicle type. Please verify the plate number and try again."
      else
        flash[:warning] = "The license plate you entered is invalid. Please try again."
      end
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def index
    if params[:search_text].present?
      @transactions = Transaction.joins(:customer).where("customers.license LIKE ?", "%#{params[:search_text]}%").order(created_at: 'DESC')
    else
      @transactions = Transaction.all.order(created_at: 'DESC')
    end
    @transaction_count = @transactions.count
    @transactions = Kaminari.paginate_array(@transactions).page(params[:page]).per(10)
  end

  def transaction_params
    params.require(:transaction).permit(:mud, :bed_down)
  end
end
