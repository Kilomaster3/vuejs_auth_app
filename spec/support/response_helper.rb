module ResponseHelper
  def response_json
    JSON.parse(response_body) rescue {}
  end
end
