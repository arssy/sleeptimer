module JsonapiResponse
  extend ActiveSupport::Concern

  private
    def error_response(status, detail)
      if status.is_a?(Symbol)
        status_name = status.to_s.humanize
        status_code = Rack::Utils.status_code(status)
      else
        status_name = Rack::Utils::SYMBOL_TO_STATUS_CODE.invert[status.to_i]&.to_s.humanize
        status_code = status
      end

      render jsonapi_errors: [{
        status: status_code.to_s,
        title: status_name,
        detail: detail
      }], status: status_code
    end
end
