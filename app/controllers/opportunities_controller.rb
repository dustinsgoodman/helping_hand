class OpportunitiesController < ApplicationController

  before_filter(:find_opportunity, :only => [:show, :edit, :update, :destroy])
  before_filter :keep_location, :only => [:new, :create, :update]

  def new
    @opportunity = Opportunity.new
  end
  
  def create
    start = params["opportunity"]["event_start"]
    temp = start[0..1]
    start[0..1] = start[3..4]
    start[3..4] = temp
        #params["opportunity"]["event_start"] = start
    dend = params["opportunity"]["event_end"]
    temp = dend[0..1]
    dend[0..1] = dend[3..4]
    dend[3..4] = temp
    params["opportunity"]["event_start"] = dend
    finalstart = DateTime.parse(start)
    finaldend = DateTime.parse(dend)
    # finalstart = DateTime.parse(params["opportunity"]["event_start"])
    # finaldend = DateTime.parse(params["opportunity"]["event_end"])
    #params["opportunity"]["event_start"] = DateTime.parse(params["opportunity"]["event_start"])
    #params["opportunity"]["event_end"] = DateTime.parse(params["opportunity"]["event_end"]) 
    #@opportunity = Opportunity.new(params["opportunity"])
    @opportunity = Opportunity.new(:name => params["opportunity"]["name"], :description => params["opportunity"]["description"], :max_ppl => params["opportunity"]["max_ppl"], :min_ppl => params["opportunity"]["min_ppl"], :num_ppl => 1, :event_start => finalstart, :event_end => finaldend)
    q = @opportunity
    if q.save
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
    @opportunity = Opportunity.find(:first, params[:id])
  end
  
end
