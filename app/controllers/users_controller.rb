class UsersController < ApplicationController
  
  skip_before_filter :store_location, :except => [:show]
  before_filter :keep_location
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :update, :change_password]
  
  before_filter(:find_user, :only => [:show, :edit, :update, :destroy, :change_password])
  
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
    @user = User.create(params[:user])
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

  private
  
  def find_user
    if logged_in?
      @user = current_user
    else
      flash[:error] = "You must be logged in."
      redirect_home
    end
  end

end
