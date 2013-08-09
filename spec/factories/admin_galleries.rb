# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_gallery, :class => 'Admin::Gallery' do
    title "MyString"
    description "MyText"
  end
end
