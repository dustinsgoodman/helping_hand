class OpportunitiesController < ApplicationController

  before_filter(:find_opportunity, :only => [:show, :edit, :update, :destroy])
  before_filter :keep_location, :only => [:new, :create, :update]

  def new
    @opportunity = Opportunity.new
  end
  
  def create
    @opportunity = Opportunity.new(params[:opportunity])
    
    if @oppportunity.save
      flash[:notice] = "Volunteering event created successfully."
      render :action => :show
    else
      flash[:error] = "Unable to make event."
      render :action => :new
    end
  end
  
  
  def edit
  end
  
  
  def update
    @opportunity.update_attributes(params[:opportunity])
    if @opportunity.valid?
      flash[:notice] = "Volunteering event updated successfully."
      #TODO update to correctly view index of events
      redirect_to_referrer_or opportunities_url
    else
      render :action => :edit
  end
  
  def destroy
    @opportunity.destroy
    #TODO: update redirection for deleted opportunities 
    redirect_to user_url
  end
 
  def show
  end
  
  private
  
  def find_opportunity
    @opportunity = Opportunities.find(params[:id])
  end
  
end