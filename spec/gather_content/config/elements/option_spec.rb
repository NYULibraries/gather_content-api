require 'spec_helper'
require 'gather_content/config/elements/option'

RSpec.describe GatherContent::Config::Element::Option do
  let(:name) { "file" }
  let(:label) { "Files" }
  let(:selected) { false }

  let(:option) { GatherContent::Config::Element::Option.new }

  before(:each) do
    option.name = name
    option.label = label
    option.selected = selected
  end

  context "when converting to JSON" do
    subject { option.serialize }

    context "a valid section instance" do
      it "has a name" do
        expect(subject[:name]).to eq(name)
      end

      it "has a label" do
        expect(subject[:label]).to eq(label)
      end

      it "has a selected flag" do
        expect(subject[:selected]).to eq(selected)
      end
    end

    context "with an empty name" do
      let(:name) { "" }

      it "raises a ArgumentError" do
        expect {
          subject
        }.to raise_error(ArgumentError)
      end
    end

    context "with an empty label" do
      let(:label) { "" }

      it "raises a ArgumentError" do
        expect {
          subject
        }.to raise_error(ArgumentError)
      end
    end

    context "selected" do
      context "is true" do
        let(:selected) { true }

        it "compiles to true" do
          expect(subject[:selected]).to eq(true)
        end
      end

      context "is false" do
        let(:selected) { false }

        it "compiles to false" do
          expect(subject[:selected]).to eq(false)
        end
      end

      context "is truthy" do
        let(:selected) { "I'm a string!" }

        it "compiles to true" do
          expect(subject[:selected]).to eq(true)
        end
      end

      context "is falsey" do
        let(:selected) { nil }

        it "compiles to false" do
          expect(subject[:selected]).to eq(false)
        end
      end
    end
  end
end
