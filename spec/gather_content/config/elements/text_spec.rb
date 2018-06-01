require 'spec_helper'
require 'gather_content/config/elements/text'

RSpec.describe GatherContent::Config::Element::Text do
  let(:name) { "text" }
  let(:required) { false }
  let(:label) { "Text" }
  let(:microcopy) { "Write some text" }
  let(:value) { "Placeholder text" }
  let(:limit_type) { :words }
  let(:limit) { 1000 }
  let(:plain_text) { false }

  let(:text) { GatherContent::Config::Element::Text.new }

  context "defaults" do
    subject { text }

    include_examples "Gather Content Defaults", "text"

    context "value" do
      it "is a blank string" do
        expect(subject.value).to eq("")
      end
    end

    context "limit_type" do
      it "is chars" do
        expect(subject.limit_type).to eq(:chars)
      end
    end

    context "limit" do
      it "is 0" do
        expect(subject.limit).to eq(0)
      end
    end

    context "plain_text" do
      it "is false" do
        expect(subject.plain_text).to eq(true)
      end
    end
  end

  context "when converting to JSON" do
    before(:each) do
      text.name = name
      text.required = required
      text.label = label
      text.microcopy = microcopy
      text.value = value
      text.limit_type = limit_type
      text.limit = limit
      text.plain_text = plain_text
    end

    subject { text.serialize }
    it_behaves_like "a Gather Content Element", "text"

    context "limit_type" do
      context "is :words" do
        let(:limit_type) { :words }

        it "is ok" do
          expect {
            subject
          }.to_not raise_error
        end

        it "converts to string" do
          expect(subject[:limit_type]).to eq("words")
        end
      end

      context "is :chars" do
        let(:limit_type) { :chars }

        it "is ok" do
          expect {
            subject
          }.to_not raise_error
        end

        it "converts to string" do
          expect(subject[:limit_type]).to eq("chars")
        end
      end

      context "with invalid limit_type" do
        let(:limit_type) { :not_valid }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end
    end

    context "limit" do
      context "is a positive number" do
        let(:limit) { 1000 }

        it "raises no exception" do
          expect(subject[:limit]).to eq(limit)
        end
      end

      context "is a negative number" do
        let(:limit) { -1000 }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end

      context "is not a number" do
        let(:limit) { "Hello" }

        it "probably casts to 0" do
          expect(subject[:limit]).to eq(0)
        end
      end
    end

    context "plain_text" do
      context "is true" do
        let(:plain_text) { true }

        it "compiles to true" do
          expect(subject[:plain_text]).to eq(true)
        end
      end

      context "is false" do
        let(:plain_text) { false }

        it "compiles to false" do
          expect(subject[:plain_text]).to eq(false)
        end
      end

      context "is truthy" do
        let(:plain_text) { "I'm a string!" }

        it "compiles to true" do
          expect(subject[:plain_text]).to eq(true)
        end
      end

      context "is falsey" do
        let(:plain_text) { nil }

        it "compiles to false" do
          expect(subject[:plain_text]).to eq(false)
        end
      end
    end
  end
end
