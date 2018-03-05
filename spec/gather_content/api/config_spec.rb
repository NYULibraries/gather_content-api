require 'spec_helper'
require 'climate_control'

describe GatherContent::Api::Config do
  subject { GatherContent::Api::Config.instance }

  let(:username) { "default" }
  let(:api_key) { "a2d8b22c-25cc-4f45-8892-2298ccf70f47" }
  let(:host) { nil }
  let(:port) { nil }

  around do |example|
    env = {
      GATHER_CONTENT_API_USERNAME: username,
      GATHER_CONTENT_API_KEY: api_key,
      GATHER_CONTENT_API_HOST: host,
      GATHER_CONTENT_API_PORT: port
    }
    ClimateControl.modify env do
      example.run
    end
  end

  describe '#default' do
    it "uses the value from GATHER_CONTENT_API_USERNAME" do
      expect(subject.username).to eq(username)
    end

    it "uses the value from GATHER_CONTENT_API_KEY" do
      expect(subject.api_key).to eq(api_key)
    end

    describe "with GATHER_CONTENT_API_HOST" do
      let(:host) { "https://env.gathercontent.com" }

      it "uses the value from GATHER_CONTENT_API_HOST" do
        expect(subject.host).to eq(host)
      end
    end

    describe "without GATHER_CONTENT_API_HOST" do
      it "uses https://api.gathercontent.com" do
        expect(subject.host).to eq("https://api.gathercontent.com")
      end
    end

    describe "with GATHER_CONTENT_API_PORT" do
      let(:port) { "1443" }

      it "uses the value from GATHER_CONTENT_API_PORT" do
        expect(subject.port).to eq(port)
      end
    end

    describe "without GATHER_CONTENT_API_PORT" do
      it "uses 443" do
        expect(subject.port).to eq("443")
      end
    end
  end

  describe '#run' do
    let(:username) { "example" }
    let(:api_key) { "baa89326-f1be-4959-93e5-effb204e5a6f" }
    let(:host) { "https://specialhost.gathercontent.com" }
    let(:port) { "8443" }

    before(:each) do
      GatherContent::Api::Config.run do |config|
        config.username = username
        config.api_key = api_key
      end
    end

    after(:each) do
      GatherContent::Api::Config.run do |config|
        config.username = nil
        config.api_key = nil
      end
    end

    it "stores the username" do
      expect(subject.username).to eq(username)
    end

    it "stores the api_key" do
      expect(subject.api_key).to eq(api_key)
    end

    it "stores the host" do
      expect(subject.host).to eq(host)
    end

    it "stores the port" do
      expect(subject.port).to eq(port)
    end
  end
end
