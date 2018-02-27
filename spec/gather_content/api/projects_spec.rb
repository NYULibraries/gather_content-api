require 'spec_helper'

describe GatherContent::Api::Projects, vcr: true do
  let(:account_id) { 123456 }
  let(:projects) { GatherContent::Api::Projects.new(account_id) }

  describe '#each' do
    subject { projects }
    it { is_expected.to be_a Enumerable }

    it 'should contain Project objects' do
      projects.each do |project|
        expect(project).to be_a GatherContent::Api::Project
      end
    end
  end
end
