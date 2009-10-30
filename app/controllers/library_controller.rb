class LibraryController < ApplicationController
  def index
    return unless require_user

    redirect_to user_library_url(:username => current_user.username)
  end

  def show
    @user = User.find_by_username(params[:username])
    @library_entries = []
    if @user.nil?
      flash[:notice] = 'No such user'
    else
      @library_entries = @user.book_editions_users(:include => { :book_edition => :book })
    end
  end
end
