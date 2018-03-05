require 'spec_helper'

describe GatherContent::Api::Files, vcr: true do
  let(:item_id) { 123456 }
  let(:files) { GatherContent::Api::Files.new(item_id) }

  describe '.new' do
    subject { files }

    context 'when project id is passed in' do
      it { is_expected.to be_a GatherContent::Api::Files }
    end

    context 'when project id is not passed in' do
      let(:item_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#each' do
    subject { files }

    it { is_expected.to be_a Enumerable }

    it 'should contain File objects' do
      subject.each do |file|
        expect(file).to be_a GatherContent::Api::File
      end
    end

    it 'should have memoized data' do
      expect(subject.first["id"]).to eq(1)
      expect(subject.first["user_id"]).to eq(1)
      expect(subject.first["item_id"]).to eq(123456)
    end
  end
end
