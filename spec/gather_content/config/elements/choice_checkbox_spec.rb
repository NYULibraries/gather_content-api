require 'spec_helper'
require 'gather_content/config/elements/choice_checkbox'
require 'gather_content/config/elements/option'
require 'gather_content/config/elements/other_option'

RSpec.describe GatherContent::Config::Element::ChoiceCheckbox do
  let(:name) { "checkbox" }
  let(:required) { false }
  let(:label) { "Choices" }
  let(:microcopy) { "Choose a thing" }
  let(:options) do
    o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1")
    o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2")

    [o1, o2]
  end

  let(:checkbox) { GatherContent::Config::Element::ChoiceCheckbox.new }

  context "defaults" do
    subject { checkbox }

    include_examples "Gather Content Defaults", "text"
  end

  context "when converting to JSON" do
    before(:each) do
      checkbox.name = name
      checkbox.required = required
      checkbox.label = label
      checkbox.microcopy = microcopy
      checkbox.options = options
    end

    subject { checkbox.serialize }
    it_behaves_like "a Gather Content Element", "choice_checkbox"

    context "options" do
      context "aren't supplied" do
        let(:options) { [] }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end

      context "are supplied" do
        let(:options) { [ GatherContent::Config::Element::Option.new("option_1", "Option 1") ] }

        it "serialises the options" do
          expect(subject[:options]).to eq(options.map{ |el| el.serialize })
        end
      end

      context "are type OtherOption" do
        let(:options) { [ GatherContent::Config::Element::OtherOption.new("option_1", "Option 1") ] }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end

      context "are not an Option type" do
        let(:options) { [ "Hello" ] }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
