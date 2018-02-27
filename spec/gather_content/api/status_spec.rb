require 'spec_helper'

describe GatherContent::Api::Status, vcr: true do
  let(:project_id) { 123456 }
  let(:status_id) { 123456 }
  let(:status) { GatherContent::Api::Status.new(project_id, status_id) }

  describe '.new' do
    subject { status }

    context 'when project id and status is is passed in' do
      it { is_expected.to be_a GatherContent::Api::Status }
    end

    context 'when project id is not passed in' do
      let(:project_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when status id is not passed in' do
      let(:status_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#fetch' do
    subject { status.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { status }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq("123456")
      expect(subject["is_default"]).to eq(true)
      expect(subject["position"]).to eq("1")
    end
  end
end
