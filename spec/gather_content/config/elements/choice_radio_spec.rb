require 'spec_helper'
require 'gather_content/config/elements/choice_radio'
require 'gather_content/config/elements/option'

RSpec.describe GatherContent::Config::Element::ChoiceRadio do
  let(:name) { "radio" }
  let(:required) { false }
  let(:label) { "Choices" }
  let(:microcopy) { "Choose a thing" }
  let(:other_option) { false }
  let(:options) do
    o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1")
    o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2")

    [o1, o2]
  end

  let(:radio) { GatherContent::Config::Element::ChoiceRadio.new }

  context "defaults" do
    subject { radio }

    include_examples "Gather Content Defaults", "text"

    context "other_option" do
      it "is false" do
        expect(subject.other_option).to eq(false)
      end
    end
  end

  context "when converting to JSON" do
    before(:each) do
      radio.name = name
      radio.required = required
      radio.label = label
      radio.microcopy = microcopy
      radio.options = options
      radio.other_option = other_option
    end

    subject { radio.serialize }
    it_behaves_like "a Gather Content Element", "choice_radio"

    context "options" do
      context "aren't supplied" do
        let(:options) { [] }

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end

      context "where none are selected" do
        let(:options) do
          o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1", false)
          o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2", false)

          [o1, o2]
        end

        it "serialises the options" do
          expect(subject[:options]).to eq(options.map{ |el| el.serialize })
        end
      end

      context "where one is selected" do
        let(:options) do
          o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1", true)
          o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2", false)

          [o1, o2]
        end

        it "serialises the options" do
          expect(subject[:options]).to eq(options.map{ |el| el.serialize })
        end
      end

      context "where more than one is selected" do
        let(:options) do
          o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1", true)
          o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2", true)

          [o1, o2]
        end

        it "raises a ArgumentError" do
          expect {
            subject
          }.to raise_error(ArgumentError)
        end
      end

      context "when other_option is false" do
        context "there is only one option" do
          let(:options) { [ GatherContent::Config::Element::Option.new("option_1", "Option 1") ] }

          it "serialises the options" do
            expect(subject[:options]).to eq(options.map{ |el| el.serialize })
          end
        end
      end

      context "when other_option is true" do
        let(:other_option) { true }

        context "there is only one option" do
          let(:options) { [ GatherContent::Config::Element::Option.new("option_1", "Option 1") ] }

          it "raises a ArgumentError" do
            expect {
              subject
            }.to raise_error(ArgumentError)
          end
        end

        context "and the last option is a OptionOther" do
          let(:options) do
            o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1")
            o2 = GatherContent::Config::Element::OtherOption.new("option_2", "Option 2")

            [o1, o2]
          end

          it "serialises the options" do
            expect(subject[:options]).to eq(options.map{ |el| el.serialize })
          end
        end

        context "and the last option is not an OtherOption" do
          let(:options) do
            o1 = GatherContent::Config::Element::Option.new("option_1", "Option 1")
            o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2")

            [o1, o2]
          end

          it "raises a ArgumentError" do
            expect {
              subject
            }.to raise_error(ArgumentError)
          end
        end

        context "the OtherOption is not the last option" do
          let(:options) do
            o1 = GatherContent::Config::Element::OtherOption.new("option_1", "Option 1")
            o2 = GatherContent::Config::Element::Option.new("option_2", "Option 2")

            [o1, o2]
          end

          it "raises a ArgumentError" do
            expect {
              subject
            }.to raise_error(ArgumentError)
          end
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
