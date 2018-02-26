require 'spec_helper'

describe GatherContent::Api::Me, vcr: true do
  let(:me) { GatherContent::Api::Me.new }

  describe '.new' do
    subject { me }

    it { is_expected.to be_a GatherContent::Api::Me }
  end

  describe '#get_me' do
    subject { me.get_me }
    it { is_expected.to be_a Hash }
  end
end
