require 'spec_helper'
require 'climate_control'

describe GatherContent::Api::Config do
  subject { GatherContent::Api::Config.instance }

  let(:username) { "default" }
  let(:api_key) { "a2d8b22c-25cc-4f45-8892-2298ccf70f47" }

  around do |example|
    ClimateControl.modify GATHER_CONTENT_API_USERNAME: username, GATHER_CONTENT_API_KEY: api_key do
      example.run
    end
  end

  describe '#default' do
    it "uses the value from GATHER_CONTENT_API_USERNAME" do
      expect(subject.username).to eq(username)
    end

    it "suses the value from GATHER_CONTENT_API_" do
      expect(subject.api_key).to eq(api_key)
    end
  end

  describe '#run' do
    let(:username) { "example" }
    let(:api_key) { "baa89326-f1be-4959-93e5-effb204e5a6f" }

    before(:each) do
      GatherContent::Api::Config.run do |config|
        config.username = username
        config.api_key = api_key
      end
    end

    it "stores the username" do
      expect(subject.username).to eq(username)
    end

    it "stores the api_key" do
      expect(subject.api_key).to eq(api_key)
    end
  end
end
