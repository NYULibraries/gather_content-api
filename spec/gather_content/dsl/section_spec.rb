require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/dsl/section'

RSpec.describe GatherContent::DSL::Section do
  let(:tab) { GatherContent::Config::Tab.new }
  let(:dsl) { GatherContent::DSL::Section.new(tab) }

  subject { tab.elements.first }

  context "setting the name" do
    let(:name) { "New Section" }
    before(:each) { dsl.name(name) }

    it "stores the name in the tab element" do
      expect(subject.name).to eq(name)
    end
  end

  context "setting the title" do
    let(:title) { "Section Title" }
    before(:each) { dsl.title(title) }

    it "stores the title in the tab element" do
      expect(subject.title).to eq(title)
    end
  end

  context "setting the subtitle" do
    let(:subtitle) { "Section Subtitle" }
    before(:each) { dsl.subtitle(subtitle) }

    it "stores the subtitle in the tab element" do
      expect(subject.subtitle).to eq(subtitle)
    end
  end
end
