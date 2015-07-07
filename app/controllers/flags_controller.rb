class FlagsController < ApplicationController
  # before_action :set_flag, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  
  # GET /flags
  # GET /flags.json
  def index
    # @flags = Flag.all
    @new_threads = NewThread.all
    @replies = Reply.all
    @users = User.all.where(blocked: true)
    
  end

  def list
  end

  # GET /flags/1
  # GET /flags/1.json


  def search
    @users = User.look(params[:search])
  end

  # GET /flags/new
  def new
    @flag = Flag.new
  end

  # GET /flags/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(flag_params)

    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: 'Flag was successfully created.' }
        format.json { render :show, status: :created, location: @flag }
      else
        format.html { render :new }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flags/1
  # PATCH/PUT /flags/1.json
  def update
    @user = User.find(params[:id])
     @user.update_attributes(user_params)
     redirect_to(:action => 'index')
    # respond_to do |format|
    #   if @flag.update(flag_params)
    #     format.html { redirect_to @flag, notice: 'Flag was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @flag }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @flag.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag.destroy
    respond_to do |format|
      format.html { redirect_to flags_url, notice: 'Flag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag
      @flag = Flag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_params
      params[:flag]
    end

    def user_params
    params.require(:user).permit(:blocked)
  end
end
