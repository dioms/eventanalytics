class CustomerSetsController < ApplicationController
  layout "sidebar"
  before_action :set_customer_set, only: [:show, :edit, :update, :destroy]

  # GET /customer_sets
  # GET /customer_sets.json
  def index
    @customer_sets = CustomerSet.all
  end

  # GET /customer_sets/1
  # GET /customer_sets/1.json
  def show
    customer_set = CustomerSet.find(params[:id])
    if customer_set.comparison == ">"
      @customers = current_user.customers.select { |c| not c.custom_data[customer_set.field].nil? }.select { |c| c.custom_data[customer_set.field] > customer_set.value }
    else
      @customers = current_user.customers.select { |c| not c.custom_data[customer_set.field].nil? }.select { |c| c.custom_data[customer_set.field] < customer_set.value }
    end
  end

  # GET /customer_sets/new
  def new
    @customer_set = CustomerSet.new
  end

  # GET /customer_sets/1/edit
  def edit
  end

  # POST /customer_sets
  # POST /customer_sets.json
  def create
    @customer_set = current_user.customer_sets.build(customer_set_params)

    respond_to do |format|
      if @customer_set.save
        format.html { redirect_to @customer_set, notice: 'Customer set was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer_set }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_sets/1
  # PATCH/PUT /customer_sets/1.json
  def update
    respond_to do |format|
      if @customer_set.update(customer_set_params)
        format.html { redirect_to @customer_set, notice: 'Customer set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_sets/1
  # DELETE /customer_sets/1.json
  def destroy
    @customer_set.destroy
    respond_to do |format|
      format.html { redirect_to customer_sets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_set
      @customer_set = CustomerSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_set_params
      params.require(:customer_set).permit(:name, :rule, :value, :comparison, :field)
    end
end