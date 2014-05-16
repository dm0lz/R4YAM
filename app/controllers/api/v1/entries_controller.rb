class Api::V1::EntriesController < Api::BaseController
  
  include EntriesHelper

  def index
    @entries = Entry.all
    filter_entries(params)
    render json: @entries, status: 200
  end

  def show
    entry = Entry.find params[:id]
    render json: entry, status: 200, location: api_v1_entry_url(entry)
  end

  def create
    entry = Entry.new(entry_params)
    if entry.save
      render json: entry, status: 201, location: api_v1_entry_url(entry)
    else
      render json: entry.errors, status: 422
    end
  end

  def update
    entry = Entry.find params[:id]
    entry.update(name: entry_params["name"], price: entry_params["price"], flag: entry_params["flag"])
    if entry.save
      render json: entry, status: 200, location: api_v1_entry_url
      #head 204, location: api_v1_entry_url
    else
      render json: entry.errors, status: 422
    end
  end

  def destroy
    entry = Entry.find params[:id]
    if entry.destroy
      render nothing: true, status: 204
    else
      render json: entry.errors, status: 422
    end
  end

  private 
  def entry_params
    params.require(:entry).permit(:name, :price, :flag, _id: {})
  end
end
