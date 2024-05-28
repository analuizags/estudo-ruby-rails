class SalesFinder < BaseFinder
  attr_reader :init_collection, :params

  def execute
    sales = init_collection
    sales = by_customer(sales)
    sales = by_status(sales)

    sales
  end

  private

  def by_customer(sales)
    return sales if params[:customer_id].nil?

    sales.where(customer_id: params[:customer_id])
  end

  def by_status(sales)
    return sales if params[:status].nil?

    sales.where(status: params[:status])
  end
end
