class Api < ApplicationRecord

  def self.handle(endpoint, request_type, params, headers)
    obj = Api.find_by(endpoint: endpoint) rescue nil
    if obj.nil? || obj.request_type.upcase != request_type
      return {code: 404, msg: 'Endpoint Not Found'}
    end
    if !obj.verify_params(params.keys) || !obj.verify_headers(headers.keys)
      return {code: 500, msg: 'Invalid request'} 
    end
    return YAML.load(obj.success_response)
  end

  def verify_params(supplied_params)
    return true if self.required_params.to_s.empty?
    params_to_verify = self.required_params.gsub(' ', '').split(',')
    params_to_verify.each do |param|
      return false if !param.in?(supplied_params)
    end
    true
  end

  def verify_headers(supplied_headers)
    return true if self.required_headers.to_s.empty?
    headers_to_verify = self.required_headers.gsub(' ', '').split(',')
    headers_to_verify.each do |header|
      return false if !qualified_header(header).in?(supplied_headers)
    end
    true
  end

  private

  def qualified_header(header)
    'HTTP_' + header.upcase.gsub('-', '_')
  end

end
