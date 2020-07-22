# Custom methods for request specs
module RequestSpecHelper
  # Parse JSON response to Ruby hash
  def json
    JSON.parse(response.body)
  end
end
