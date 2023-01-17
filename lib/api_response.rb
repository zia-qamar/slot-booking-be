# frozen_string_literal: true

module ApiResponse
  RESPONSE_TYPE = {
    success: 201,
    api_error: 422,
    not_found: 404
  }.freeze

  def map_status(response_type)
    key = RESPONSE_TYPE.key?(response_type.to_sym) ? response_type.to_sym : :api_error

    RESPONSE_TYPE[key]
  end
end
