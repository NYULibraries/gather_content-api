RSpec.shared_examples "a Gather Content DSL" do
  context "setting the name" do
    let(:name) { "New Section" }
    before(:each) { dsl.name(name) }

    it "stores the name in the tab element" do
      expect(subject.name).to eq(name)
    end
  end

  context "setting the label" do
    let(:label) { "Label" }
    before(:each) { dsl.label(label) }

    it "stores the label in the tab element" do
      expect(subject.label).to eq(label)
    end
  end

  context "setting required" do
    let(:required) { true }
    before(:each) { dsl.required(required) }

    it "stores the required flag in the tab element" do
      expect(subject.required).to eq(required)
    end
  end

  context "setting the microcopy" do
    let(:microcopy) { "Microcopy" }
    before(:each) { dsl.microcopy(microcopy) }

    it "stores the microcopy in the tab element" do
      expect(subject.microcopy).to eq(microcopy)
    end
  end
end

RSpec.shared_examples "Gather Content Defaults" do
  context "name" do
    it "is a blank string" do
      expect(subject.name).to eq("")
    end
  end

  context "label" do
    it "is a blank string" do
      expect(subject.label).to eq("")
    end
  end

  context "required" do
    it "is false" do
      expect(subject.required).to eq(false)
    end
  end

  context "microcopy" do
    it "is a blank string" do
      expect(subject.microcopy).to eq("")
    end
  end
end
