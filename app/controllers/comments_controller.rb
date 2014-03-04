class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  before_filter :authenticate_user!
  def index
      @comments = Comment.all
      redirect_to user_entries_path
    end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
      @comment = Comment.new
      @comment.user_id = current_user_account.id
  end

  def create
      @comment = Comment.new(comment_params)

      if @comment.save
        redirect_to :controller => 'user_entries', :action => 'show', :id => @comment.user_entry_id
      else
        render :new
      end
  end

  def edit
      @comment = Comment.find(params[:id])
      if @comment.user_id != current_user_account.id
        @comment = nil
      end
  end

  def update
      @comment = Comment.find(params[:id])

      if @comment.update_attributes(comment_params)
        redirect_to :controller => 'user_entries', :action => 'show', :id => @comment.user_entry_id
      else
        render :edit
      end
  end

  def destroy
      @comment = Comment.find(params[:id])
      if @comment.user_id = current_user_account.id
        @comment.destroy
        redirect_to :controller => 'user_entries', :action => 'show', :id => @comment.user_entry_id
      end
  end

  private

  def comment_params
      params.require(:comment).permit!
  end



  # def index
  #   @commentable = find_commentable 
  #   @comments = Comment.all
  # end
  
  # def show
  #   @comment = Comment.find(params[:id])
  # end
  
  # def new
  #   # @comment = Comment.new
  #   # @comment.user_id = current_user.id
  #   # @commentable = current_user.entries.where( params[:id])

  #   # if params[:entry_id]
  #   #   @entry = Entry.where(id: params[:entry_id]).first
  #   #   @comment = current_user.entries.new(entry: @entry)
  #   # else
  #   #   flash[:error] = "Friend required"
  #   # end
  #   @entry = Entry.find(params[:id])
  #   @comment = @entry.comments.new(params[:id])
  # end
  
  # def create
  #   # @commentable = find_commentable
  #   # @comment = @commentable.comments.build(comment_params)
  #   # if @comment.save
  #   #   flash[:notice] = "Successfully created comment."
  #   #   redirect_to :id => nil
  #   # else
  #   #   render :action => 'new'
  #   # end
  #   if params[:comment] && params[:comment].has_key?(:entry_id)
  #     @entry = Entry.where(id: params[:comment][:entry_id]).first
  #     @comment = Friendship.request(current_user, @entry)
  #     respond_to do |format|
  #       if @comment.new_record?
  #         format.html do
  #           flash[:error] = "There was a problem creating that entry request."
  #           redirect_to profile_path(@entry)
  #         end
  #         format.json { render json: @comment.to_json, status: :precondition_failed }
  #       else
  #         format.html do
  #           flash[:success] = "Friend request sent!"
  #           redirect_to profile_path(@entry)
  #         end
  #         format.json { render json: @comment.to_json }
  #       end
  #     end
  #   else
  #     flash[:error] = "Friend required"
  #     redirect_to root_path
  #   end
  # end
  
  # def edit
  #   @comment = Comment.find(params[:id])
  # end
  
  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update_attributes(params[:comment])
  #     flash[:notice] = "Successfully updated comment."
  #     redirect_to @comment
  #   else
  #     render :action => 'edit'
  #   end
  # end
  
  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #   flash[:notice] = "Successfully destroyed comment."
  #   redirect_to comments_url
  # end
  
  # private

  # def find_commentable
  #   params.each do |name, value|
  #     if name =~ /(.+)_id$/
  #       return $1.classify.constantize.find(value)
  #     end
  #   end
  #   nil
  # end
  # # Use callbacks to share common setup or constraints between actions.
  # def set_comment
  #   @comment = Comment.find(params[:id])
  # end

  # # Never trust parameters from the scary internet, only allow the white list through.
  # def comment_params
  #   params.require(:comment).permit(:content, :user_id)
  # end

  # def entry_params
  #   params.require(:entry).permit(:title, :description, :photo, :user_id)
  # end
  
end
