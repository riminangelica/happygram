class EntriesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  #before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all.order("created_at DESC")
    # @friendships = Friendship.where("(user_account_id = ? AND status='Accepted')", current_user_account.id)
    @friendships = FriendshipDecorator.decorate_collection(friendship_association.all)
    @accepted = current_user.friendships.where(state: :accepted)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.new
  end

  # GET /entries/1/edit
  def edit
    @entry = current_user.entries.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Your entry has been posted!' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    @entry = current_user.entries.find(params[:id])
    
    if params[:entry] && params[:entry].has_key?(:user_id)
      params[:entry].delete(:user_id)
    end

    respond_to do |format|
      if @entry.update_attributes(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  def add_entry_comment
      @entry = Entry.find(params[:id])
      @comment = Comment.new
      @comment.user_id = current_user_account.id
      @comment.entry_id = @entry.id
      render "comments/new"
  end

  def edit_entry_comment
      @entry = Entry.find(params[:id])
      @comment = Comment.find(params[:entry_comment_id])
      if @comment.user_id != current_user_account.id
        @comment = nil
      end
      render "comments/edit"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :description, :photo, :user_id)
    end
end
