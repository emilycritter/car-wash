class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @customer = Customer.new
  end

  def create
    @transaction = Transaction.new transaction_params
    @customer = Customer.find_or_create_by(
      license: params[:transaction][:license].html_safe,
      vehicle_type: params[:transaction][:truck] == "on" ? "truck" : "car"
    )
    if @customer.id
      session[:user_id] = @customer.id
      @transaction.customer_id = @customer.id
      case
      when $stolen_plates.include?(@customer.license)
        flash[:alert] = "Calling 911! Reporting stolen vehicle"
      when @transaction.bed_down == true
        flash[:warning] = "Sorry, we cannot offer you a car wash code at this time. Please ensure the bed of your truck is up and try again"
      when @transaction.discount != 0
        flash[:notice] = "Congratulations! You received a discount!"
      end
      redirect_to transaction_path(id: @transaction.id) if @transaction.save
    else
      @customer = Customer.find_by(license: params[:transaction][:license])
      if @customer && @customer.id
        flash[:warning] = "The license plate you entered is associated with a different vehicle type. Please verify the plate number and try again"
      else
        flash[:warning] = "The license plate you entered is invalid. Please try again"
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
