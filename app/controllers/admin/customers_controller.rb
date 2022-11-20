class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    #@customers = Customer.page(params[:page])
    @customers = Customer.all
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(customer_params) ? (redirect_to admin_customer_path(@customer)) : (render :edit)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end
end
