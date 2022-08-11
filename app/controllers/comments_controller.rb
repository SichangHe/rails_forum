class CommentsController < ApplicationController
  ONLY_SET_COMMENTABLE = %i[index new create].freeze

  before_action :set_comment, except: ONLY_SET_COMMENTABLE
  before_action :authenticate_user!, except: %i[index show votes]
  before_action :set_commentable, only: ONLY_SET_COMMENTABLE

  # GET /comments or /comments.json
  def index
    @comments = Comment.order(created_at: :desc)
                       .where(commentable_id: @commentable_id, commentable_type: @commentable_type)
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Set commentable's id and type
  def set_commentable
    @commentable_id = params[:commentable_id]
    @commentable_type = params[:commentable_type]
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment)
          .permit(:commentable_id, :commentable_type, :content, :status)
          .reverse_merge(user_id: current_user.id)
  end
end
