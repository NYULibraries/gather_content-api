require 'spec_helper'

describe GatherContent::Api::Account, vcr: true do
  let(:account_id) { 123456 }
  let(:account) { GatherContent::Api::Account.new(account_id) }

  describe '.new' do
    subject { account }

    it { is_expected.to be_a GatherContent::Api::Account }
  end

  describe '#fetch' do
    subject { account.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { account }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq("123456")
      expect(subject["name"]).to eq("Example")
      expect(subject["slug"]).to eq("example")
      expect(subject["timezone"]).to eq("UTC")
    end
  end
end
