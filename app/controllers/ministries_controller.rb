class MinistriesController < ApplicationController
  before_action :set_ministry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:index, :show]

  # GET /ministries
  # GET /ministries.json
  def index
    @ministries = Ministry.all
  end

  # GET /ministries/1
  # GET /ministries/1.json
  def show
  end

  # GET /ministries/new
  def new
    @ministry = Ministry.new
  end

  # GET /ministries/1/edit
  def edit
  end

  # POST /ministries
  # POST /ministries.json
  def create
    @ministry = Ministry.new(ministry_params)

    respond_to do |format|
      if @ministry.save
        format.html { redirect_to @ministry, notice: 'Ministry was successfully created.' }
        format.json { render :show, status: :created, location: @ministry }
      else
        format.html { render :new }
        format.json { render json: @ministry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ministries/1
  # PATCH/PUT /ministries/1.json
  def update
    respond_to do |format|
      if @ministry.update(ministry_params)
        format.html { redirect_to @ministry, notice: 'Ministry was successfully updated.' }
        format.json { render :show, status: :ok, location: @ministry }
      else
        format.html { render :edit }
        format.json { render json: @ministry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ministries/1
  # DELETE /ministries/1.json
  def destroy
    @ministry.destroy
    respond_to do |format|
      format.html { redirect_to ministries_url, notice: 'Ministry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ministry
      @ministry = Ministry.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ministry_params
      params.require(:ministry).permit(:name, :short_name)
    end
end
