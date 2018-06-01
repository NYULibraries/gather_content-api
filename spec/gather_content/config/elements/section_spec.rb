require 'spec_helper'
require 'gather_content/config/elements/section'

RSpec.describe GatherContent::Config::Element::Section do
  let(:name) { "section" }
  let(:title) { "Section Title" }
  let(:subtitle) { "Section Subtitle" }

  let(:section) { GatherContent::Config::Element::Section.new }

  context "defaults" do
    subject { section }

    context "name" do
      it "is an empty string" do
        expect(subject.name).to eq("")
      end
    end

    context "title" do
      it "is an empty string" do
        expect(subject.title).to eq("")
      end
    end

    context "subtitle" do
      it "is an empty string" do
        expect(subject.subtitle).to eq("")
      end
    end
  end

  context "when converting to JSON" do
    before(:each) do
      section.name = name
      section.title = title
      section.subtitle = subtitle
    end

    subject { section.serialize }

    it "has the correct type" do
      expect(subject[:type]).to eq("section")
    end

    context "a valid section instance" do
      it "has a name" do
        expect(subject[:name]).to eq(name)
      end

      it "has a title" do
        expect(subject[:title]).to eq(title)
      end

      it "has a subtitle" do
        expect(subject[:subtitle]).to eq(subtitle)
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

    context "with an empty title" do
      let(:title) { "" }

      it "raises a ArgumentError" do
        expect {
          subject
        }.to raise_error(ArgumentError)
      end
    end
  end
end
