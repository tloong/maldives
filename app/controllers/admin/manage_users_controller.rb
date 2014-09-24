class Admin::ManageUsersController < AdminController

before_action :admin_required

  def index 
    if params[:approved] == "false"
      @users = User.where(:approved => false)
    else
      @users = User.all
    end
  end

  def approve_user

    @user = User.find(params[:user_id])
    @user.approved = true
    @user.save

    redirect_to admin_manage_users_path
  end

end