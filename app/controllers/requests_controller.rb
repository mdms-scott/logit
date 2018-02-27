class RequestsController < ApplicationController
  def index
    # Get the requests for the specifed page
    @requests = Request.page(params[:page])

    # Overwrite the requests if there is a query or boolean specification
    if params[:q]
      @requests = Request.where("full_body LIKE '%#{params[:q]}%'").page(params[:page])
    end
    if params[:warnings]
      @requests = Request.where(has_warning: true)
    end
    if params[:slowest]
      @requests = Request.order(total_time: :desc)
    end
    
    render json: @requests
  end
end
