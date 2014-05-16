require 'spec_helper'

describe Entry do
  
  it "should have a name" do
    entry = FactoryGirl.create(:entry)
    expect(entry.name).to_not be_nil
  end



end
