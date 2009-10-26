class UsersController < ApplicationController
  def new
    return unless require_no_user

    @user = User.new
  end

  def create
    return unless require_no_user

    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_back_or_default edit_user_url('current')
    else
      render :action => 'new'
    end
  end

  def edit
    return unless require_user

    @user = current_user
  end

  def update
    return unless require_user

    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_back_or_default edit_user_url('current')
    else
      render :action => 'edit'
    end
  end
end
