module Helpers

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def json_success(response)
    response.status.should be 200
    response.body.should_not be_empty
    response.content_type.should be Mime::JSON
  end

  def xml_success(response)
    response.status.should be 200
    response.body.should_not be_empty
    response.content_type.should be Mime::XML
  end
end