require 'spec_helper'

describe GatherContent::Api::Me, vcr: true do
  let(:me) { GatherContent::Api::Me.new }

  describe '.new' do
    subject { me }

    it { is_expected.to be_a GatherContent::Api::Me }
  end

  describe '#fetch' do
    subject { me.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { me }

    it "returns the data related to the supplied key" do
      expect(subject["email"]).to eq("andrew@gathercontent.com")
      expect(subject["first_name"]).to eq("Andrew")
      expect(subject["last_name"]).to eq("Cairns")
    end
  end
end
