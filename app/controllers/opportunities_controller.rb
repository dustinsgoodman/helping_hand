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
      redirect_to_referrer_or opportunities_url
    else
      render :action => :edit
  end
  
  def destroy
    @opportunity.destroy
    redirect_to user_url(current_user)
  end
 
  def show
  end
  
  def eligible?
    if @opportunity.max_ppl > num_ppl
      if current_user.age >= @opportunity.min_age && current_user.age <= @opportunity.max_age
        true
      end
    end
    false
  end
  
  private
  
  def find_opportunity
    @opportunity = Opportunities.find(params[:id])
  end
  
end