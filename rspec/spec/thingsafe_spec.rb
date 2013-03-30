require 'httparty'

url_base="http://localhost:8080/"

describe "ThingSafe" do
  it "stores a thing" do
    thing = { :title => "My Thing" }
    response = HTTParty.post(url_base + "hello-world", thing)
    response.code.should eq(200)
  end
end
