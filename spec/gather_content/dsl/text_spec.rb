require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/dsl/text'

RSpec.describe GatherContent::DSL::Text do
  let(:tab) { GatherContent::Config::Tab.new }
  let(:dsl) { GatherContent::DSL::Text.new(tab) }

  subject { tab.elements.first }

  it_behaves_like "a Gather Content DSL"

  context "setting the value" do
    let(:value) { "Value" }
    before(:each) { dsl.value(value) }

    it "stores the value in the tab element" do
      expect(subject.value).to eq(value)
    end
  end

  context "setting the limit_type" do
    let(:limit_type) { :char }
    before(:each) { dsl.limit_type(limit_type) }

    it "stores the limit_type in the tab element" do
      expect(subject.limit_type).to eq(limit_type)
    end
  end

  context "setting the limit" do
    let(:limit) { 2000 }
    before(:each) { dsl.limit(limit) }

    it "stores the limit in the tab element" do
      expect(subject.limit).to eq(limit)
    end
  end

  context "setting the plain_text flag" do
    let(:plain_text) { true }
    before(:each) { dsl.plain_text(plain_text) }

    it "stores the plain_text in the tab element" do
      expect(subject.plain_text).to eq(plain_text)
    end
  end
end
