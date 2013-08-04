require 'spec_helper'

describe Article do

  before(:each) do
    @attr = {
      :title=>"Cakma bir baslik",
      :content =>"Burasi detay kısmı haberin...",
      :publish_date =>Time.now
    }

  end

  subject { Article.create(@attr) }

describe "Attributes" do


  it  "should respond to title" do

        should respond_to(:title)

  end

   it  "should respond to content" do

        should respond_to(:content)

  end

  it  "should respond to category_id" do

        should respond_to(:category_id)

  end

 # its(:content) { should be_valid }

end

end


