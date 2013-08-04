require 'spec_helper'

describe Article do


describe "Attributes" do

    it {should respond_to(:title)}
    it {should respond_to(:content)}
    it {should respond_to(:category_id)}
    it {should accept_nested_attributes_for(:pictures)}

end

describe "validations" do
   let(:category) { FactoryGirl.create(:category)}
  context "should pass valid data" do

    let(:article) { FactoryGirl.create(:article, category: category)}
    subject { article }

    it { should be_valid}

  end

  context "without valid title" do

    let(:article) { Article.new(title: "")}
    subject { article }

    it { should_not be_valid}

  end

  context "without valid content" do

    let(:article) { Article.new(title: "News", content: "")}
    before { article.save}
    subject { article }


    it { should_not be_valid}

  end

  context "without enough content" do

    let(:article) { Article.new(title: "News", content: "#{"a"*29}")}
    before { article.save}
    subject { article }

    it { should_not be_valid}

  end

  context "without category_id" do

    let(:article) { Article.new(title: "News", content: "#{"a"*10}", category_id: nil)}
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

end


