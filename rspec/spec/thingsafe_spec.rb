require 'httparty'
require 'json'

url_base="http://localhost:8080/"

describe "ThingSafe" do
  it "stores a thing" do
    thing = { :name => "My Thing" }.to_json
    headers = { 'Content-Type' => 'application/json', 'Authorization' => 'OAuth oauth_token="letmein"' }
    response = HTTParty.put(url_base + "mythings", :body => thing, :headers => headers)

    response.code.should eq(204)
  end
  it "retrieves my things" do
    headers = { 'Authorization' => 'OAuth oauth_token="letmein"' }
    response = HTTParty.get(url_base + "mythings", :headers => headers)

    response.code.should eq(200)
    response.body.should eq([{:name => "My Thing", :user => "testuser" }].to_json)
  end
end


