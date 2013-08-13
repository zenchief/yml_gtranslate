require 'spec_helper'

describe YmlGtranslate do
  
  before { @gt = YmlGtranslate::Translator.new("en", "de", "") }
  
  it "asserts comment token properly suffixed" do
    
    @gt.comment("stuff").should eq("stuff" + YmlGtranslate::Translator::COMMENT_TOKEN)
  end
  
  it "checks german translation" do
    @gt.translate("Good morning").should eq("guten Morgen")
  end
  
  it "checks comparing empty hashes" do
    @gt.compare({},{}).should eq({})
  end
  

end
