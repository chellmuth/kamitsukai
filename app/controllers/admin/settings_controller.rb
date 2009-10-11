class Admin::SettingsController < ApplicationController
  permit "administrator", :get_user_method => :current_user

  def index
    @settings = Setting.all(:order => 'key')
  end

  def show
    @setting = Setting.find(params[:id])
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(params[:setting])

    if @setting.save
      flash[:notice] = "Setting successfully created."
      redirect_to admin_settings_path
    else
      render :action => 'new'
    end
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Successfully updated setting."
      redirect_to admin_setting_path(@setting)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @setting = begin Setting.find(params[:id]) rescue nil end

    if !@setting.nil? && @setting.destroy
      flash[:notice] = "Setting successfully removed."
      redirect_to admin_settings_path
    else
      flash[:notice] = "Unable to remove setting."
      redirect_to admin_settings_path
    end
  end
end
