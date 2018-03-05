require 'spec_helper'

describe GatherContent::Api::Accounts, vcr: true do
  let(:accounts) { GatherContent::Api::Accounts.new }

  describe '#each' do
    subject { accounts }

    it { is_expected.to be_a Enumerable }

    it 'should contain Account objects' do
      subject.each do |account|
        expect(account).to be_a GatherContent::Api::Account
      end
    end

    it 'should have memoized data' do
      expect(subject.first["id"]).to eq("123456")
      expect(subject.first["name"]).to eq("Example")
      expect(subject.first["slug"]).to eq("example")
      expect(subject.first["timezone"]).to eq("UTC")
    end
  end
end
