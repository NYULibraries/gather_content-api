require 'spec_helper'
require 'gather_content/config/builder'
require 'gather_content/dsl/tab'
require 'gather_content/config/elements/text'
require 'gather_content/config/elements/files'
require 'gather_content/config/elements/choice_checkbox'
require 'gather_content/config/elements/choice_radio'
require 'gather_content/config/elements/section'

RSpec.describe GatherContent::DSL::Text do
  let(:builder) { GatherContent::Config::Builder.new }
  let(:dsl) { GatherContent::DSL::Tab.new(builder) }

  subject { builder.tabs.first }

  context "setting the label" do
    let(:label) { "Label" }
    before(:each) { dsl.label(label) }

    it "stores the label in the builder" do
      expect(subject.label).to eq(label)
    end
  end

  context "setting the name" do
    let(:name) { "Name" }
    before(:each) { dsl.name(name) }

    it "stores the name in the builder" do
      expect(subject.name).to eq(name)
    end
  end

  context "setting the hidden flag" do
    let(:hidden) { true }
    before(:each) { dsl.hidden(hidden) }

    it "stores the hidden flag in the builder" do
      expect(subject.hidden).to eq(hidden)
    end
  end

  context "adding a text element" do
    before(:each) do
      dsl.text do
        label "text_label"
        name "Text Label"
      end
    end

    it "adds the text element to the tab" do
      expect(subject.elements.first).to be_instance_of(GatherContent::Config::Element::Text)
    end
  end

  context "adding a files element" do
    before(:each) do
      dsl.files do
        label "files_label"
        name "Files Label"
      end
    end

    it "adds the files element to the tab" do
      expect(subject.elements.first).to be_instance_of(GatherContent::Config::Element::Files)
    end
  end

  context "adding a choice_radio element" do
    before(:each) do
      dsl.choice_radio do
        label "choice_radio_label"
        name "Choice Radio Label"
      end
    end

    it "adds the choice_radio element to the tab" do
      expect(subject.elements.first).to be_instance_of(GatherContent::Config::Element::ChoiceRadio)
    end
  end

  context "adding a choice_checkbox element" do
    before(:each) do
      dsl.choice_checkbox do
        label "choice_checkbox_label"
        name "Choice Checkbox Label"
      end
    end

    it "adds the choice_checkbox element to the tab" do
      expect(subject.elements.first).to be_instance_of(GatherContent::Config::Element::ChoiceCheckbox)
    end
  end

  context "adding a section element" do
    before(:each) do
      dsl.section do
        name "section"
        title "Title"
      end
    end

    it "adds the section element to the tab" do
      expect(subject.elements.first).to be_instance_of(GatherContent::Config::Element::Section)
    end
  end
end
