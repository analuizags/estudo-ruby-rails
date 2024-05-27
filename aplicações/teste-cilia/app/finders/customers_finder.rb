class CustomersFinder < BaseFinder
  attr_reader :init_collection, :params

  def execute
    customers = init_collection
    customers = by_name(customers)
    customers = by_email(customers)
    customers = by_active(customers)

    customers
  end

  private

  def by_name(customers)
    return customers if params[:name].nil?

    customers.where("customers.name ILIKE ?", "%#{params[:name]}%")
  end

  def by_email(customers)
    return customers if params[:email].nil?

    customers.where(email: params[:email])
  end

  def by_active(customers)
    return customers if params[:active].nil?

    customers.where(active: params[:active])
  end
end
