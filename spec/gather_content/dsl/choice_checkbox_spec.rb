require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/dsl/choice_checkbox'

RSpec.describe GatherContent::DSL::ChoiceCheckbox do
  let(:tab) { GatherContent::Config::Tab.new }
  let(:dsl) { GatherContent::DSL::ChoiceCheckbox.new(tab) }

  subject { tab.elements.first }

  it_behaves_like "a Gather Content DSL"

  context "setting the options" do
    before(:each) do
      dsl.option do
        name "option_1"
        label "Option 1"
      end
    end

    it "stores the options in the tab element" do
      expect(subject.options.first).to be_instance_of(GatherContent::Config::Element::Option)
    end
  end
end
