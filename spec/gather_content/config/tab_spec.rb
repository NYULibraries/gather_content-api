require 'spec_helper'
require 'gather_content/config/tab'

RSpec.describe GatherContent::Config::Tab do
  let(:name) { "tab" }
  let(:label) { "Tab" }
  let(:hidden) { false }
  let(:elements) { [] }

  let(:tab) { GatherContent::Config::Tab.new }

  context "defaults" do
    subject { tab }

    context "name" do
      it "is an empty string" do
        expect(subject.name).to eq("")
      end
    end

    context "label" do
      it "is an empty string" do
        expect(subject.label).to eq("")
      end
    end

    context "hidden" do
      it "is false" do
        expect(subject.hidden).to eq(false)
      end
    end

    context "elements" do
      it "is an empty array" do
        expect(subject.elements).to eq([])
      end
    end
  end

  context "when converting to JSON" do
    before(:each) do
      tab.name = name
      tab.label = label
      tab.hidden = hidden
      tab.elements = elements
    end

    subject { tab.serialize }

    it "has a name" do
      expect(subject[:name]).to eq(name)
    end

    it "has a hidden flag" do
      expect(subject[:hidden]).to eq(hidden)
    end

    it "has a label" do
      expect(subject[:label]).to eq(label)
    end

    it "has elements" do
      expect(subject[:elements]).to eq(elements)
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

    context "hidden" do
      context "is true" do
        let(:hidden) { true }

        it "compiles to true" do
          expect(subject[:hidden]).to eq(true)
        end
      end

      context "is false" do
        let(:hidden) { false }

        it "compiles to false" do
          expect(subject[:hidden]).to eq(false)
        end
      end

      context "is truthy" do
        let(:hidden) { "I'm a string!" }

        it "compiles to true" do
          expect(subject[:hidden]).to eq(true)
        end
      end

      context "is falsey" do
        let(:hidden) { nil }

        it "compiles to false" do
          expect(subject[:hidden]).to eq(false)
        end
      end
    end
  end
end
