class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.html do
      end
    end
    @opportunity = Opportunity.all
  end
end
