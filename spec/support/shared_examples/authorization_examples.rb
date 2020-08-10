RSpec.shared_examples "unauthorized_request" do |parameter|
  it "responds with 401 code" do
    expect(response.status).to eq 401
  end
  it "responds with unauthorized message" do
    body = JSON.parse(response.body)
    expect(body["msg"]).to eq "Bad credentials"
  end
end
