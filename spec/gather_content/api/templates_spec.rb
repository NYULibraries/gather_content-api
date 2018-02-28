require 'spec_helper'

describe GatherContent::Api::Templates, vcr: true do
  let(:project_id) { 123456 }
  let(:templates) { GatherContent::Api::Templates.new(project_id) }

  describe '#each' do
    subject { templates }
    it { is_expected.to be_a Enumerable }

    it 'should contain Template objects' do
      templates.each do |template|
        expect(template).to be_a GatherContent::Api::Template
      end
    end

    it 'should have memoized data' do
      expect(subject.first["id"]).to eq(123456)
      expect(subject.first["project_id"]).to eq(123456)
      expect(subject.first["name"]).to eq("Blog Theme")
    end
  end
end
