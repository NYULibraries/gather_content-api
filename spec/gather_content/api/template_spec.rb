require 'spec_helper'

describe GatherContent::Api::Template, vcr: true do
  let(:template_id) { '123456' }
  let(:template) { GatherContent::Api::Template.new(template_id) }

  describe '.new' do
    subject { template }

    context 'when template ID is passed in' do
      it { is_expected.to be_a GatherContent::Api::Template }
    end

    context 'when template ID is not passed in' do
      let(:template_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#fetch' do
    subject { template.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { template }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq(123456)
      expect(subject["project_id"]).to eq(123456)
      expect(subject["name"]).to eq("Blog Theme")
    end
  end
end
