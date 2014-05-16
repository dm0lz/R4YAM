module EntriesHelper

  def filter_entries params
    if name = params[:name]
      @entries = @entries.where(name: name)
    end
    if price = params[:price]
      @entries = @entries.where(price: price)
    end
    if flag = params[:flag]
      @entries = @entries.where(flag: flag)
    end
    @entries
  end
  
end
