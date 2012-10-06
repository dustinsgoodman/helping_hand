class UserController < ApplicationController
  def index
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update

  end

  def create
    @user = User.create(params)
    if @user.save
      flash[:notice] = "User created succesfully"
      render :
    else

    end
  end

  def destroy
    @user.destroy
    redirect_to user_path
  end

  def show

  end

end
