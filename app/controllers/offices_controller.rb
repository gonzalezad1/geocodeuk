class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]
  before_action :set_api_params, only: [:create]
  before_action :set_postcode_params, only: [:create]
  # GET /offices
  # GET /offices.json
  def index
    @offices = Office.search(params[:search_postcode],params[:search_radius])
  end

  # GET /offices/1
  # GET /offices/1.json
  def show
  end

  # GET /offices/new
  def new
    @office = Office.new
  end

  # GET /offices/1/edit
  def edit
  end

  # POST /offices
  # POST /offices.json
  def create
    @office = Office.new(name: params[:office][:name],lat: @params_entry.lat,lng: @params_entry.lng,address: params[:office][:address], postcode: @params_postcode)
    respond_to do |format|
      if @office.save
        format.html { redirect_to offices_path, notice: 'Office was successfully created.' }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offices/1
  # PATCH/PUT /offices/1.json
  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity, notice: 'Your address is not valid' }
      end
    end
  end

  # DELETE /offices/1
  # DELETE /offices/1.json
  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, notice: 'Office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_office
    @office = Office.find(params[:id])
  end

  def set_api_params
    @params_entry =Office.uri_lat_long(params[:office][:address])

  end
  def set_postcode_params
    if @params_entry && @params_entry.lat && @params_entry.lng
      @params_postcode = Office.uri_postcode(@params_entry.lat,@params_entry.lng)
    else
      flash[:notice] =  "Adress: #{params[:office][:address]} is not valid."
      redirect_to offices_path
    end
  end
  def office_params
    params.require(:office).permit(:name, :lat,:lng, :postcode,:address)
  end
end
