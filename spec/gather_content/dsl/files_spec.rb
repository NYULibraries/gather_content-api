require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/dsl/files'

RSpec.describe GatherContent::DSL::Files do
  let(:tab) { GatherContent::Config::Tab.new }
  let(:dsl) { GatherContent::DSL::Files.new(tab) }

  subject { tab.elements.first }

  it_behaves_like "a Gather Content DSL"
end
