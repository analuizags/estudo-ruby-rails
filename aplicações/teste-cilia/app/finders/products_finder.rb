class ProductsFinder < BaseFinder
  attr_reader :init_collection, :params

  def execute
    products = init_collection
    products = by_name(products)
    products = by_active(products)

    products
  end

  private

  def by_name(products)
    return products if params[:name].nil?

    products.where("products.name ILIKE ?", "%#{params[:name]}%")
  end

  def by_active(products)
    return products if params[:active].nil?

    products.where(active: params[:active])
  end
end
