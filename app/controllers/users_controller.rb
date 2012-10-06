class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  
  def index
    @user = User.find(:all)
  end

  def new
    @user = User.new
  end

  def update
    @user.update_attributes(params[:id])
    if @user.valid?
      flash[:notice] = "User updated succesfully"
      render :action => :show
    else
      render :action => :edit
    end
  end

  def create
    @user = User.create(params)
    if @user.save
      flash[:notice] = "User created succesfully"
      render :action => :show
    else
      flash[:error] = "Unable to make User"
      render :action => :new
    end
  end

  def destroy
    @user.destroy
    #TODO: update redirection for deleted user
    redirect_to user_path
  end

  def edit
  end

  def show
  end

end
