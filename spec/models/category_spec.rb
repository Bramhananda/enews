require 'spec_helper'

describe Category do

  describe "attributes" do

    it { should respond_to(:title)}
    it { should respond_to(:parent_id)}
    it { should validate_presence_of :title}


  end

  describe "creates category with valid data" do
    let(:category) { FactoryGirl.create(:category)}
    subject { category}
    before { category.save}
    it { should be_valid}
  end

  describe "#list" do
    subject { Category }
    it { should respond_to(:list) }
  end



end
