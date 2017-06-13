class CommentsController < ApplicationController
  before_action :set_law
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:show]

  # GET /laws/1/comments/1
  # GET /laws/1/comments/1.json
  def show
  end

  # GET /laws/1/comments/new
  def new
    @comment = @law.comments.new
    @comment.build_document
  end

  # GET /laws/1/comments/1/edit
  def edit
  end

  # POST /laws/1/comments
  # POST /laws/1/comments.json
  def create
    @comment = @law.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@law, @comment], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: [@law, @comment] }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laws/1/comments/1
  # PATCH/PUT /laws/1/comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@law, @comment], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@law, @comment] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laws/1/comments/1
  # DELETE /laws/1/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to law_comments_url(@law), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_law
      @law = Law.friendly.find(params[:law_id])
    end

    def set_comment
      @comment = @law.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(
        :draft_id, :document_id, :asked_at, :answered_at,
        organization_ids: [],
        document_attributes: [:source_url]
      )
    end
end
