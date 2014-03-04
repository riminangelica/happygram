class CommentsController < InheritedResources::Base
	before_filter :authenticate_user!
  def index
      @comments = Comment.all
      redirect_to entries_path
    end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
      @comment = Comment.new
      @comment.user_id = current_user.id
  end

  def create
      @comment = Comment.new(comment_params)
      @entry = Entry.find_by_id(params[:id])

      if @comment.save
        redirect_to :controller => 'entries', :action => 'show', :id => @comment.entry_id
      else
        render :new
      end
  end

  def edit
      @comment = Comment.find(params[:id])
      if @comment.user_id != current_user.id
        @comment = nil
      end
  end

  def update
      @comment = Comment.find(params[:id])

      if @comment.update_attributes(comment_params)
        redirect_to :controller => 'entries', :action => 'show', :id => @comment.entry_id
      else
        render :edit
      end
  end

  def destroy
      @comment = Comment.find(params[:id])
      if @comment.user_id = current_user.id
        @comment.destroy
        redirect_to :controller => 'entries', :action => 'show', :id => @comment.entry_id
      end
  end

  private

  def comment_params
      params.require(:comment).permit!
  end
end
