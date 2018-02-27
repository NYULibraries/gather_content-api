require 'spec_helper'

describe GatherContent::Api::Statuses, vcr: true do
  let(:project_id) { 123456 }
  let(:statuses) { GatherContent::Api::Statuses.new(project_id) }

  describe '.new' do
    subject { statuses }

    context 'when project id is passed in' do
      it { is_expected.to be_a GatherContent::Api::Statuses }
    end

    context 'when project id is not passed in' do
      let(:project_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#each' do
    subject { statuses }

    it { is_expected.to be_a Enumerable }

    it 'should contain Status objects' do
      subject.each do |status|
        expect(status).to be_a GatherContent::Api::Status
      end
    end

    it 'should have memoized data' do
      expect(subject.first["id"]).to eq("123456")
      expect(subject.first["is_default"]).to eq(true)
      expect(subject.first["position"]).to eq("1")
    end
  end
end
