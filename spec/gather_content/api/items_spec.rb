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

  describe "#create" do
    let(:name) { "Test Item" }

    subject { items.create({'name' => name}) }

    context 'with name' do
      it "created an item" do
        expect(subject).to be_a GatherContent::Api::Item
      end

      it "set the item id" do
        expect(subject.item_id).to eq("6498974")
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

    context 'on non-202 response' do
      it 'raises an RequestError' do
        expect { subject }.to raise_error GatherContent::Error::RequestError
      end

      it 'sets the RequestError message' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.message).to eq("")
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
