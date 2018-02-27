require 'spec_helper'

describe GatherContent::Api::Items, vcr: true do
  let(:project_id) { '123456' }
  let(:items) { GatherContent::Api::Items.new(project_id) }

  describe '.new' do
    subject { items }

    context 'when project ID is passed in' do
      it { is_expected.to be_a GatherContent::Api::Items }
    end

    context 'when project ID is not passed in' do
      let(:project_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#each' do
    subject { items }

    it { is_expected.to be_a Enumerable }

    it 'should contain Item objects' do
      subject.each do |item|
        expect(item).to be_a GatherContent::Api::Item
      end
    end

    it 'should have memoized data' do
      expect(subject.first["id"]).to eq(123456)
      expect(subject.first["project_id"]).to eq(123456)
      expect(subject.first["parent_id"]).to eq(0)
    end
  end
end
