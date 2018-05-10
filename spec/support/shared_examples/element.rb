RSpec.shared_examples "a Gather Content Element" do |type|
  it "has the correct type" do
    expect(subject[:type]).to eq(type)
  end

  context "a valid section instance" do
    it "has a name" do
      expect(subject[:name]).to eq(name)
    end

    it "has a required flag" do
      expect(subject[:required]).to eq(required)
    end

    it "has a label" do
      expect(subject[:label]).to eq(label)
    end

    it "has microcopy" do
      expect(subject[:microcopy]).to eq(microcopy)
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

  context "with an empty label" do
    let(:label) { "" }

    it "raises a ArgumentError" do
      expect {
        subject
      }.to raise_error(ArgumentError)
    end
  end

  context "required" do
    context "is true" do
      let(:required) { true }

      it "compiles to true" do
        expect(subject[:required]).to eq(true)
      end
    end

    context "is false" do
      let(:required) { false }

      it "compiles to false" do
        expect(subject[:required]).to eq(false)
      end
    end

    context "is truthy" do
      let(:required) { "I'm a string!" }

      it "compiles to true" do
        expect(subject[:required]).to eq(true)
      end
    end

    context "is falsey" do
      let(:required) { nil }

      it "compiles to false" do
        expect(subject[:required]).to eq(false)
      end
    end
  end
end
