require 'spec_helper'

describe GatherContent::Api::Project, vcr: true do
  let(:project_id) { 123456 }
  let(:project) { GatherContent::Api::Project.new(project_id) }

  describe '.new' do
    subject { project }

    it { is_expected.to be_a GatherContent::Api::Project }
  end

  describe '#project_id' do
    subject { project.project_id }
    it { is_expected.to eql project_id }
  end

  describe '#get_project' do
    subject { project.get_project }
    it { is_expected.to be_a Hash }
  end
end
