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

  describe "#create" do
    let(:name) { "Test Project" }
    let(:type) { "website-build" }

    subject { projects.create({'name' => name, 'type' => type}) }

    context 'with name and valid type' do
      it "created a project" do
        expect(subject).to be_a GatherContent::Api::Project
      end

      it "set the project id" do
        expect(subject.project_id).to eq("161823")
      end
    end

    context 'with no name' do
      let(:name) { nil }

      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'with empty name' do
      let(:name) { "" }

      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'with no type' do
      let(:type) { nil }

      it "created a project" do
        expect(subject).to be_a GatherContent::Api::Project
      end
    end

    context 'with empty type' do
      let(:type) { "" }

      it "created a project" do
        expect(subject).to be_a GatherContent::Api::Project
      end
    end

    context 'with invalid type' do
      let(:type) { "invalid" }

      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'on non-202 response' do
      it 'raises an RequestError' do
        expect { subject }.to raise_error GatherContent::Error::RequestError
      end

      it 'sets the RequestError message' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.message).to eq("Account not found")
        end
      end

      it 'sets the RequestError status' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.status).to eq(200)
        end
      end
    end
  end
end
