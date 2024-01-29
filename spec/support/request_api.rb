module RequestAPI
  def body_json(symbolize_keys: false)
    json = JSON.parse(response.body)
    symbolize_keys ? json.deep_symbolize_keys : json
  rescue
    return {}
  end

  def auth_header(user = nil, merge_with: {})
    user ||= create(:user)
    auth = user.create_new_auth_token
    header = auth.merge({ "Content-type" => "Application/json", "Accept" => "Application/json" })
    header.merge(merge_with)
  end

  def unauthenticated_header(merge_with: {})
    { "Content-type" => "Application/json", "Accept" => "Application/json" }.merge(merge_with)
  end
end

RSpec.configure do |config|
  config.include RequestAPI, type: :request
end
