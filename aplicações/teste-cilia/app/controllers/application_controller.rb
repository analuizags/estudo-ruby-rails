class ApplicationController < ActionController::Base
  private

  def check_authenticate
    :authenticate_admin! || :authenticate_customer!
  end
end
