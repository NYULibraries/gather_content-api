require 'spec_helper'
require 'gather_content/config/elements/files'

RSpec.describe GatherContent::Config::Element::Files do
  let(:name) { "file" }
  let(:required) { false }
  let(:label) { "Files" }
  let(:microcopy) { "Upload a file" }

  let(:files) { GatherContent::Config::Element::Files.new }

  before(:each) do
    files.name = name
    files.required = required
    files.label = label
    files.microcopy = microcopy
  end

  context "when converting to JSON" do
    subject { files.serialize }
    it_behaves_like "a Gather Content Element", "files"
  end
end
