require 'spec_helper'
include Warden::Test::Helpers

  describe "User sign up" do
    subject { page }

    describe "exists properly" do
      before { visit new_user_registration_path}
      it { should have_selector("h1", text: "Kayıt") }
      it { should have_content("Kayıt") }
    end

     describe "fills the form with valid data" do
      let(:name) { "Testcan"}

          before do
            visit new_user_registration_path
            fill_in "Adı soyadı", with: name
            fill_in "E-posta", with: "hebe@hebe.com"
            fill_in "Şifre", with: "123456"
            fill_in "Şifre (tekrar)", with: "123456"
            login_as User.last
          end

        it {  expect {  click_button "Kayıt ol" }.to change(User, :count ) }
       it { should have_content("Haberler") }
     end

  end
describe "User Page after signin" do
  subject { page }
   let(:user) { FactoryGirl.create(:user)}
    before do
      login_as user
    end

  describe "user edit auth" do
     before {  visit edit_user_registration_path(user) }
     it { should have_content("Hesap ayarları") }

     describe "fills the form with valid data" do
          before do
            fill_in "Adı soyadı", with: "Testcan"
            fill_in "E-posta", with: "hebe@hebe.com"
            fill_in "Şu anki şifre", with: user.password
            click_button "Güncelle"
          end

          it { should have_content("Hesabınızı başarıyla güncellediniz.") }
     end

     describe "fills the form with invalid data" do
          before do
            fill_in "Adı soyadı", with: "Testcan"
            fill_in "E-posta", with: "hebe@hsssebe.com"
            fill_in "Şu anki şifre", with: "sdsds"
            click_button "Güncelle"
          end

          it { should have_selector("i", "icon-remove") }
     end

  end




end
