class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(exception)
    render jsonapi_errors: [{status: "404", title: "Not Found", detail: exception.message }], status: :not_found
  end
end
