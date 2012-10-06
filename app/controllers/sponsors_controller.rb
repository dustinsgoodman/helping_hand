class SponsorsController < ApplicationController

  skip_before_filter :store_location, :except => [:show]
  before_filter :keep_location

  before_filter :require_no_sponsor, :only => [:new, :create]
  before_filter :require_sponsor, :only => [:show, :update, :change_password]

  before_filter(:find_sponsor, :only => [:show, :edit, :update, :destroy, :change_password])

  def index
    @sponsor = Sponsor.find(:all)
  end

  def new
    @sponsor =Sponsor.new
  end

  def update
    @sponsor.update_attributes(params[:id])
    if @sponsor.valid?
      flash[:notice] = "Sponsor updated succesfully"
      render :action => :show
    else
      render :action => :edit
    end
  end

  def create
    @sponsor = sponsor.create(params)
    if @sponsor.save
      flash[:notice] = "Sponsor created succesfully"
      render :action => :show
    else
      flash[:error] = "Unable to make sponsor"
      render :action => :new
    end
  end

  def destroy
    @sponsor.destroy
    #TODO: update redirection for deleted sponsor
    redirect_to sponsor_path
  end

  def edit
  end

  def show
  end

  private

  def find_user
    if logged_in?
      @sponsor = current_user
    else
      flash[:error] = "You must be logged in."
      redirect_home
    end
  end

end
