require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/dsl/choice_radio'

RSpec.describe GatherContent::DSL::ChoiceRadio do
  let(:tab) { GatherContent::Config::Tab.new }
  let(:dsl) { GatherContent::DSL::ChoiceRadio.new(tab) }

  subject { tab.elements.first }

  it_behaves_like "a Gather Content DSL"

  context "setting the options" do
    before(:each) do
      dsl.option do
        name "option_1"
        label "Option 1"
      end
    end

    it "stores the options in choice radio" do
      expect(subject.options.first).to be_instance_of(GatherContent::Config::Element::Option)
    end
  end

  context "setting the other_option" do
    before(:each) do
      dsl.other_option do
        name "option_1"
        label "Option 1"
        value "value"
      end
      dsl.option do
        name "option_1"
        label "Option 1"
      end
    end

    it "store the option as the last option" do
      expect(subject.options.last).to be_instance_of(GatherContent::Config::Element::OtherOption)
    end

    it "sets other_option to true" do
      expect(subject.other_option).to eq(true)
    end
  end
end
