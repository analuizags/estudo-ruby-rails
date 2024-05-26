# frozen_string_literal: true

class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_customer!
  before_action :configure_sign_up_params, only: [:create]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.addresses.build
    resource.phones.build
    respond_with resource
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys:[
        :email, :password, :password_confirmation,
        :name, :document, :birthdate,
        addresses_attributes: [:id, :street, :number, :district, :city, :state, :zipcode, :_destroy],
        phones_attributes: [:id, :ddd, :number, :_destroy]
      ]
    )
  end
end
