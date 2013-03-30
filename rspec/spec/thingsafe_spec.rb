require 'httparty'
require 'json'

url_base="http://localhost:8080/"

describe "ThingSafe" do
  it "stores a thing" do
    thing = { :title => "My Thing" }.to_json
    headers = { 'Content-Type' => 'application/json' }
    response = HTTParty.put(url_base + "mythings", :body => thing, :headers => headers)

    response.code.should eq(200)
  end
end


