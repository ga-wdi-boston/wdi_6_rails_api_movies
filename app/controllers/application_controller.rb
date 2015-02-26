class ApplicationController < ActionController::API
  # remove root node from JSON
  def default_serializer_options
    {root: false}
  end

end
