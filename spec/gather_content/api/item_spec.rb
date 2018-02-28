require 'spec_helper'

describe GatherContent::Api::Item, vcr: true do
  let(:item_id) { '123456' }
  let(:item) { GatherContent::Api::Item.new(item_id) }

  describe '.new' do
    subject { item }

    context 'when item ID is passed in' do
      it { is_expected.to be_a GatherContent::Api::Item }
    end

    context 'when item ID is not passed in' do
      let(:item_id) { nil }
      it 'should raise an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe '#fetch' do
    subject { item.fetch }
    it { is_expected.to be_a Hash }
  end

  describe "[]" do
    subject { item }

    it "returns the data related to the supplied key" do
      expect(subject["id"]).to eq(123456)
      expect(subject["project_id"]).to eq(123456)
      expect(subject["parent_id"]).to eq(0)
    end
  end

  describe "apply_template" do
    subject { item.apply_template(template_id) }

    context "successful" do
      let(:template_id) { 654321 }

      it "returns true" do
        expect(subject).to eq(true)
      end
    end

    context "unsuccessful" do
      let(:template_id) { 567890 }
      it 'raises an RequestError' do
        expect { subject }.to raise_error GatherContent::Error::RequestError
      end

      it 'sets the RequestError status' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.status).to eq(500)
        end
      end

      it 'parses the message' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.message).to eq("unknown error")
        end
      end
    end

  end

  describe "choose_status" do
    subject { item.choose_status(status_id) }

    context "successful" do
      let(:status_id) { 654321 }

      it "returns true" do
        expect(subject).to eq(true)
      end
    end

    context "unsuccessful" do
      let(:status_id) { 567890 }
      it 'raises an RequestError' do
        expect { subject }.to raise_error GatherContent::Error::RequestError
      end

      it 'sets the RequestError status' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.status).to eq(500)
        end
      end

      it 'parses the message' do
        begin
          subject
        rescue GatherContent::Error::RequestError => e
          expect(e.message).to eq("unknown error")
        end
      end
    end
  end
end
