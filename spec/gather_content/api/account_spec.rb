require 'spec_helper'

describe GatherContent::Api::Account, vcr: true do
  let(:account_id) { 123456 }
  let(:account) { GatherContent::Api::Account.new(account_id) }

  describe '.new' do
    subject { account }

    it { is_expected.to be_a GatherContent::Api::Account }
  end

  describe '#account_id' do
    subject { account.account_id }
    it { is_expected.to eql account_id }
  end

  describe '#get_account' do
    subject { account.get_account }
    it { is_expected.to be_a Hash }
  end
end
