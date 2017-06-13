class DraftsController < ApplicationController
  before_action :set_law
  before_action :set_draft, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:show]

  # GET /laws/1/drafts/1
  # GET /laws/1/drafts/1.json
  def show
  end

  # GET /laws/1/drafts/new
  def new
    @draft = Draft.new
    @draft.build_document
  end

  # GET /laws/1/drafts/1/edit
  def edit
  end

  # POST /laws/1/drafts
  # POST /laws/1/drafts.json
  def create
    @draft = @law.drafts.new(draft_params)

    respond_to do |format|
      if @draft.save
        format.html { redirect_to [@law, @draft], notice: 'Draft was successfully created.' }
        format.json { render :show, status: :created, location: @law }
      else
        format.html { render :new }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laws/1/drafts/1
  # PATCH/PUT /laws/1/drafts/1.json
  def update
    respond_to do |format|
      if @draft.update(draft_params)
        format.html { redirect_to @law, notice: 'Draft was successfully updated.' }
        format.json { render :show, status: :ok, location: @law }
      else
        format.html { render :edit }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laws/1/drafts/1
  # DELETE /laws/1/drafts/1.json
  def destroy
    @draft.destroy
    respond_to do |format|
      format.html { redirect_to law_url(@law), notice: 'Draft was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_law
      @law = Law.friendly.find(params[:law_id])
    end

    def set_draft
      @draft = Draft.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def draft_params
      params.require(:draft).permit(:published_at, :document_id, document_attributes: [:source_url])
    end
end
