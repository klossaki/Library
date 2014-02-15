class AdminsController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
    authorize! :edit, @user
  end
  
  def edit_user
    @user = User.find(params[:user_id])
    authorize! :edit, @user
  end
  
  def update
    @user = User.find(params[:user_id])
    authorize! :update, @user
    if @user.update!(user_params)
	     flash[:notice] = "Successfully updated User."
	     redirect_to admins_path
	  else
      flash[:notice] = "Failed to update User."
	     render :action => 'edit'
	   end
	end
  

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    if @user.destroy
      flash[:notice] = "User successfully deleted"
      redirect_to admins_path
    else
      flash[:notice] = "User could not be deleted"
  end
 
  
  private
  
  def user_params
    params.require(:user).permit(:admin)
  end
  
end
