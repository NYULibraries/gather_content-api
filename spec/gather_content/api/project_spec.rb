require 'spec_helper'

describe GatherContent::Api::Project, vcr: true do
  let(:project_id) { 123456 }
  let(:project) { GatherContent::Api::Project.new(project_id) }

  describe '.new' do
    subject { project }

    it { is_expected.to be_a GatherContent::Api::Project }
  end

  describe '#get' do
    subject { project.project_id }
    it { is_expected.to eql project_id }
  end

  describe '#fetch' do
    subject { project.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { project }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq(123456)
      expect(subject["name"]).to eq("Example Project")
      expect(subject["account_id"]).to eq(123456)
    end
  end
end
