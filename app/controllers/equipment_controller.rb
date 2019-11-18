class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_equipment, only: %i[edit update destroy]
  before_action :license_check, only: %i[create update]

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all
  end

  # GET /equipment/new
  def new
    if policy(:application).show?
      redirect_to equipment_index_url(
        open: true, page: helpers.getter_equipment.total_pages
      )
    else
      redirect_to equipment_index_url, notice: 'Access denied.'
    end
  end

  # GET /equipment/1/edit
  def edit
    respond_to do |format|
      format.html { redirect_to equipment_index_url }
      format.js
    end
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    respond_to do |format|
      if @equipment.save
        format.html do
          redirect_to equipment_index_url,
            notice: 'Equipment added.'
        end
      else
        format.html { render :new }
        format.json do
          render json: @equipment.errors,
          status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html do
          redirect_to equipment_index_url,
            notice: 'Equipment edited.'
        end
      else
        format.html { render :edit }
        format.json do
          render json: @equipment.errors,
          status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html do
        redirect_to equipment_index_url,
          notice: 'Equipment deleted.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_equipment
    @equipment = Equipment.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to equipment_index_url, notice: 'Record not found.'
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def equipment_params
    params.require(:equipment).permit(
      :name, :equipment_type, :status, :user_id, :serial_number)
  end

  def license_check
    params[:equipment].delete :serial_number unless
      params[:equipment][:equipment_type].eql?('license')
  end
end
