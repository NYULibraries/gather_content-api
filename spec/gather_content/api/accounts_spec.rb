require 'spec_helper'

describe GatherContent::Api::Accounts, vcr: true do
  let(:accounts) { GatherContent::Api::Accounts.new }

  describe '#each' do
    subject { accounts }
    it { is_expected.to be_a Enumerable }
    it 'should contain Account objects' do
      accounts.each do |account|
        expect(account).to be_a GatherContent::Api::Account
      end
    end
  end
end
