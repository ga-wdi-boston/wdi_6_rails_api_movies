class ErrorsController < ApplicationController

  # All of the default HTTP status codes returned from Rails.
  # ActionDispatch::ExceptionWrapper.rescue_responses.values.uniq
  #  => [:not_found,
  # :method_not_allowed,
  # :not_implemented,
  # :not_acceptable,
  # :unprocessable_entity,
  # :bad_request,
  # :conflict]

  # All of the default HTTP status codes returned from Rails.
  # AND their symbols and messages.
  # ActionDispatch::ExceptionWrapper.rescue_responses.values.uniq.map do |status_symbol|
  #   code =  Rack::Utils.status_code(status_symbol)
  #   msg = Rack::Utils::HTTP_STATUS_CODES[code]
  #   [status_symbol, code, msg]
  # end

  # [[:not_found, 404, "Not Found"],
  #  [:method_not_allowed, 405, "Method Not Allowed"],
  #  [:not_implemented, 501, "Not Implemented"],
  #  [:not_acceptable, 406, "Not Acceptable"],
  #  [:unprocessable_entity, 422, "Unprocessable Entity"],
  #  [:bad_request, 400, "Bad Request"],
  #  [:conflict, 409, "Conflict"]]

  def not_found
    exception = env["action_dispatch.exception"]

    error_info = {
      :error => 'not_found',
      :original_path => env["action_dispatch.original_path"],
      :status => 404,
      :exception => "#{exception.class.name} : #{exception.message}"
    }
    render :json => error_info.to_json, :status => :not_found
  end

  def method_not_allowed
  end

  def not_implemented
  end

  def not_acceptable
  end

  def unprocessable_entity
  end

  def bad_request
  end

  def conflict
  end

end
