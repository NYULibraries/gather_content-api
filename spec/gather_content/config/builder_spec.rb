require 'spec_helper'
require 'gather_content/config/tab'
require 'gather_content/config/builder'

RSpec.describe GatherContent::Config::Builder do
  context "adding a tab element" do
    it "adds the tab" do
      builder = GatherContent::Config::Builder.build do
        tab do
          label "text_label"
          name "Text Label"
        end
      end

      expect(builder.first).to be_instance_of(GatherContent::Config::Tab)
    end
  end

  context "to_json" do
    it "returns a JSON object" do
      builder = GatherContent::Config::Builder.build do
        tab do
          label "text_label"
          name "Text Label"

          text do
            name "Text"
            label "text"
            required false
            value ""
            microcopy ""
            limit_type :chars
            limit 255
            plain_text true
          end
        end
      end

      expect(JSON.parse(builder.to_json)).to eq(JSON.parse([{"label": "text_label", "name": "Text Label", "hidden": false, "elements": [{"name": "Text", "required": false, "label": "text", "microcopy": "", "type": "text", "value": "", "limit_type": "chars", "limit": 255, "plain_text": true}]}].to_json))
    end
  end
end
