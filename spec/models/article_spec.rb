require 'spec_helper'

describe Article do
  let(:category) { FactoryGirl.create(:category)}
  before(:each) do
    @attr = {
      :title => "News",
      :content => "It's a content having at least 10 characters.",
      :category_id => category.id,
      :publish_date => "2013-07-10 05:35:46",
      :tag_list => "test1, test2"
    }
  end

# VALIDATIONS
it { should validate_presence_of(:title) }
it { should validate_presence_of(:content) }

describe "Attributes" do

    it {should respond_to(:title)}
    it {should respond_to(:content)}
    it {should respond_to(:category_id)}
    it {should accept_nested_attributes_for(:pictures)}

end

describe "has associations" do
  it {should have_many(:pictures).through(:multimedia)}
  it {should belong_to :category}
end

describe "validations" do

  context "should pass with valid data" do

    let(:article) {Article.new(@attr)}
    subject { article }

    it { should be_valid}

  end


  context "without enough content" do

    let(:article) { Article.new(@attr.merge(content: "#{"a"*9}"))}
    before { article.save}
    subject { article }

    it { should_not be_valid}

  end

  context "without category_id" do

    let(:article) { Article.new(@attr.merge(category_id: nil))}
    before { article.save}
    subject { article }

    it { should_not be_valid}

  end

  context "without picture" do

    let(:article) { Article.new(title: "News", content: "#{"a"*10}", category_id: category.id, pictures_attributes: {})}
    before { article.save}
    subject { article }

    xit { should_not be_valid}

  end


end

  describe "when a columnist inserted an article" do
    let!(:columnist) { FactoryGirl.create(:columnist)}
    let!(:article) { FactoryGirl.create(:article, user: columnist, active: false)} 
    subject { article }
    its('active') { should == false}
  end

end


