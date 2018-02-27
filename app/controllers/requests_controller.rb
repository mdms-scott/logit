class RequestsController < ApplicationController
  def index
    @requests = Request.page(params[:page])
    if params[:q]
      @requests = Request.where("full_body LIKE '%#{params[:q]}%'").page(params[:page])
    end
    if params[:warnings]
      @requests = Request.where(has_warning: true)
    end
    if params[:slowest]
      @requests = @requests.order(total_time: :desc)
    end
    render json: @requests
  end
  def show
    @request = Request.find(params[:id])
    render json: @request
  end
end
