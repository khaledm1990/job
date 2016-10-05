class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :update, :destroy]

  # GET /phones
  # GET /phones.json
  def index
    @phones = Phone.all
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    # byebug
    @user = User.find(params[:user_id])
    @phone = Phone.new
  end

  # GET /phones/1/edit
  def edit
    @user = User.find(params[:user_id])
  end

  # POST /phones
  # POST /phones.json
  def create
    @user = User.find(params[:user_id])
    @phone = @user.phones.new(phone_params)
      # byebug
    respond_to do |format|
      if @phone.save
        format.html { redirect_to root_path, notice: 'Phone was successfully created.' }
        format.json { render :show, status: :created, location: @phone }
        format.js
      else
        format.html { render :new }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1
  # PATCH/PUT /phones/1.json
  def update
    respond_to do |format|
      @user = @phone.user
      if @phone.update(phone_params)
        format.html { redirect_to root_path, notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Phone was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:number, :user_id)
    end
end
