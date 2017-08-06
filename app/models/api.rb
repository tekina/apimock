class Api < ApplicationRecord

  def self.handle(endpoint, request_type, params, headers)
    obj = Api.find_by(endpoint: endpoint) rescue nil
    if obj.nil? || obj.request_type.upcase != request_type
      return { code: 404, msg: 'Endpoint Not Found' }
    end
    header_error = obj.verify_headers(headers.keys)

    # check if all required headers are present in request
    if header_error.length > 0
      return { code: 500, msg: "Missing headers: #{error}" }
    end

    # check if all required params are present in request
    params_error = obj.verify_params(params.keys)
    if params_error.length > 0
      return { code: 500, msg: "Missing params: #{params_error}" }
    end

    # all good, parse and return success_response
    # YAML might fail for some cases, but JSON will work in those cases
    return YAML.load(obj.success_response) rescue JSON.load(obj.success_response)
  end

  # returns a list of missing params, if any
  def verify_params(supplied_params)
    missing_params = ''
    return missing_params if self.required_params.to_s.empty?
    params_to_verify = self.required_params.gsub(' ', '').split(',')
    params_to_verify.each do |param|
      missing_params << "#{param} " if !param.in?(supplied_params)
    end
    return missing_params
  end

  # returns a list of missing headers, if any
  def verify_headers(supplied_headers)
    missing_headers = ''
    return missing_headers if self.required_headers.to_s.empty?
    headers_to_verify = self.required_headers.gsub(' ', '').split(',')
    headers_to_verify.each do |header|
      missing_headers << "#{header} " if !qualified_header(header).in?(supplied_headers)
    end
    return missing_headers
  end

  private

  def qualified_header(header)
    'HTTP_' + header.upcase.gsub('-', '_')
  end

end
