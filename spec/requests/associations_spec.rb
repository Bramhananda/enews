require 'spec_helper'

describe "Associations" do

  		let(:article) { FactoryGirl.create(:article)}
  		stub_paperclip(Picture)
  		let(:picture) { FactoryGirl.create(:picture)}
  		let(:gallery) { FactoryGirl.create(:gallery)}

context "through article" do
  subject { article }
  
  describe "picture should be inside" do 	
  	before { article.pictures << picture }
  	its(:pictures) { should include(picture)}
  end

  describe "gallery should be inside" do 	
  	before { article.galleries << gallery }
  	its(:galleries) { should include(gallery)}
  end

end

context "through gallery" do
  subject { gallery }
  
  describe "picture should be inside" do 	
  	before { gallery.pictures << picture }
  	its(:pictures) { should include(picture)}
  end

  describe "gallery should be inside" do 	
  	before { gallery.articles << article }
  	its(:articles) { should include(article)}
  end

end

 context "through pictures" do
  subject { picture }
  
  describe "given picture with article" do 	
  	before { picture.articles << article }
  	its(:articles) { should include(article)}
  end

  describe "given picture with article" do 	

  	it "should count" do
  		expect { picture.articles << article }.to change{Multimedium.count}.by(1)
  	end
  end

  describe "given picture with gallery" do 	
  	before { picture.galleries << gallery }
  	its(:galleries) { should include(gallery)}
  end

end

end
