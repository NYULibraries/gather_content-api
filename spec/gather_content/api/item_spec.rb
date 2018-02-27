require 'spec_helper'

describe GatherContent::Api::Item, vcr: true do
  let(:item_id) { '123456' }
  let(:item) { GatherContent::Api::Item.new(item_id) }

  describe '.new' do
    subject { item }

    context 'when item ID is passed in' do
      it { is_expected.to be_a GatherContent::Api::Item }
    end

    context 'when item ID is not passed in' do
      let(:item_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#fetch' do
    subject { item.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { item }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq(123456)
      expect(subject["project_id"]).to eq(123456)
      expect(subject["parent_id"]).to eq(0)
    end
  end
end
